package cc

import (
	"encoding/json"
	"fmt"
	"strings"
)

func (s *SmartContract) InitLedger(ctx TCI) error {
	items := []CertItem{
		{ID: "Item-Test1", UserID: "Admin", Status: OtherStatus,
			ReqTime: "", IsuTime: "", RvkTime: "", ExpDays: 0, Key: ""},
		{ID: "Item-Test2", UserID: "Guest", Status: OtherStatus,
			ReqTime: "", IsuTime: "", RvkTime: "", ExpDays: 0, Key: ""},
	}

	waitingList := make([]string, 0)
	waitingJSON, err := json.Marshal(waitingList)
	if err != nil {
		return err
	}

	err = ctx.GetStub().PutState("WaitingList", waitingJSON)
	if err != nil {
		return err
	}

	for _, item := range items {
		itemJSON, err := json.Marshal(item)
		if err != nil {
			return err
		}
		err = ctx.GetStub().PutState(item.ID, itemJSON)
		if err != nil {
			return fmt.Errorf("failed to put world state. %v", err)
		}
	}
	return nil
}

func (s *SmartContract) hasItem(ctx TCI, id string) (bool, error) {
	itemJSON, err := ctx.GetStub().GetState(id)
	if err != nil {
		return false, fmt.Errorf("failed to read world state. %v", err)
	}

	return itemJSON != nil, nil
}

func (s *SmartContract) GetCert(ctx TCI, id string) (*CertItem, error) {
	itemJSON, err := ctx.GetStub().GetState(id)
	if err != nil {
		return nil, fmt.Errorf("failed to get world state. %v", err)
	}
	if itemJSON == nil {
		return nil, fmt.Errorf("no such item. %s", id)
	}

	certItem := CertItem{}
	err = json.Unmarshal(itemJSON, &certItem)
	if err != nil {
		return nil, err
	}

	return &certItem, nil
}

func (s *SmartContract) GetAllCerts(ctx TCI) ([]*CertItem, error) {
	itemsIter, err := ctx.GetStub().GetStateByRange("", "")
	if err != nil {
		return nil, err
	}
	defer itemsIter.Close()

	items := make([]*CertItem, 0)
	for itemsIter.HasNext() {
		item, err := itemsIter.Next()
		if err != nil {
			return nil, err
		}

		if !strings.HasPrefix(item.Key, "Item-") {
			continue
		}

		CertItem := CertItem{}
		err = json.Unmarshal(item.Value, &CertItem)
		if err != nil {
			return nil, err
		}

		items = append(items, &CertItem)
	}
	return items, nil
}

func (s *SmartContract) GetAllPeers(ctx TCI) (map[string]string, error) {
	allPeersJSON, err := ctx.GetStub().GetState("AllPeers")
	if err != nil {
		return nil, err
	}

	allPeers := make(map[string]string, 0)
	err = json.Unmarshal(allPeersJSON, &allPeers)
	if err != nil {
		return nil, err
	}

	return allPeers, nil
}

func (s *SmartContract) GetWaitingList(ctx TCI) ([]string, error) {
	waitingJSON, err := ctx.GetStub().GetState("WaitingList")
	if err != nil {
		return nil, fmt.Errorf("failed to get world state. %v", err)
	}

	waitingList := make([]string, 0)
	err = json.Unmarshal(waitingJSON, &waitingList)
	if err != nil {
		return nil, err
	}

	return waitingList, nil
}

func (s *SmartContract) putWaitingList(ctx TCI, waitingList []string) error {
	waitingJSON, err := json.Marshal(waitingList)
	if err != nil {
		return err
	}

	err = ctx.GetStub().PutState("WaitingList", waitingJSON)
	if err != nil {
		return err
	}

	return nil
}

func (s *SmartContract) AddToWaitingList(ctx TCI, id string) error {
	waitingList, err := s.GetWaitingList(ctx)
	if err != nil {
		return err
	}

	waitingList = append(waitingList, id)
	err = s.putWaitingList(ctx, waitingList)
	if err != nil {
		return err
	}

	return nil
}
