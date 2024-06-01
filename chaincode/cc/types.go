package cc

import "github.com/hyperledger/fabric-contract-api-go/contractapi"

type TCI contractapi.TransactionContextInterface

type SmartContract struct {
	contractapi.Contract
}

type CertItem struct {
	ID      string `json:"ID"`
	UserID  string `json:"UsrID"`
	Status  int    `json:"Status"`
	ExpDays int    `json:"ExpDays"`
	ReqTime string `json:"ReqTime"`
	IsuTime string `json:"IsuTime"`
	RvkTime string `json:"RvkTime"`
	Key     string `json:"Key"`
	// History []string `json:"History"`
}

const (
	ValidCert = iota
	InvalidCert
	UnauthedCert
	OutdatedCert
	RevokedCert
	OtherStatus
)
