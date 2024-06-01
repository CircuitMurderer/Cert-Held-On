package web

import (
	"fmt"
	"net/http"

	"github.com/hyperledger/fabric-gateway/pkg/client"
)

// Invoke handles chaincode invoke requests.
func (c *Connector) Invoke(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Received Invoke request")
	if err := r.ParseForm(); err != nil {
		fmt.Fprintf(w, "ParseForm() err: %s", err)
		return
	}

	chainCodeName := c.Config.CcType
	channelID := c.Config.Channel

	function := r.FormValue("function")
	args := r.Form["args"]
	fmt.Printf("channel: %s, chaincode: %s, function: %s, args: %s\n", channelID, chainCodeName, function, args)
	
	network := c.Gateway.GetNetwork(channelID)
	contract := network.GetContract(chainCodeName)
	txn_proposal, err := contract.NewProposal(function, client.WithArguments(args...))
	if err != nil {
		fmt.Fprintf(w, "Error creating txn proposal: %s", err)
		return
	}

	txn_endorsed, err := txn_proposal.Endorse()
	if err != nil {
		fmt.Fprintf(w, "Error endorsing txn: %s", err)
		return
	}

	txn_committed, err := txn_endorsed.Submit()
	if err != nil {
		fmt.Fprintf(w, "Transaction ID: %s, Error submitting transaction: %s", txn_committed.TransactionID(), err)
		return
	}

	// fmt.Fprintf(w, "Transaction ID : %s Response: %s", txn_committed.TransactionID(), txn_endorsed.Result())
	fmt.Fprintf(w, "%s", txn_endorsed.Result())
}

// Query handles chaincode query requests.
func (c *Connector) Query(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Received Query request")
	queryParams := r.URL.Query()
	chainCodeName := c.Config.CcType
	channelID := c.Config.Channel

	function := queryParams.Get("function")
	args := r.URL.Query()["args"]
	fmt.Printf("channel: %s, chaincode: %s, function: %s, args: %s\n", channelID, chainCodeName, function, args)
	
	network := c.Gateway.GetNetwork(channelID)
	contract := network.GetContract(chainCodeName)
	evaluateResponse, err := contract.EvaluateTransaction(function, args...)
	if err != nil {
		fmt.Fprintf(w, "Error: %s", err)
		return
	}

	fmt.Fprintf(w, "%s", evaluateResponse)
}
