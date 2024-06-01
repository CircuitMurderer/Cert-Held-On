package web

import (
	"fmt"
	"log"
	"net/http"
	"time"

	"github.com/hyperledger/fabric-gateway/pkg/client"
)

func NewConnectorFrom(filePath string) (*Connector, error) {
	conn, err := createConnFrom(filePath)
	if err != nil {
		return nil, err
	}

	log.Printf("Creating connection for %s...\n", conn.Config.OrgName)
	clientConn := conn.createConnect()

	gtw, err := client.Connect(
		conn.createID(),
		client.WithSign(conn.createSign()),
		client.WithClientConnection(clientConn),
		client.WithEvaluateTimeout(5*time.Second),
		client.WithEndorseTimeout(15*time.Second),
		client.WithSubmitTimeout(5*time.Second),
		client.WithCommitStatusTimeout(1*time.Minute),
	)
	if err != nil {
		return nil, err
	}

	conn.Gateway = gtw
	log.Println("Creation complete.")
	return conn, nil
}

func Serve(conn Connector) {
	http.HandleFunc("/query", conn.Query)
	http.HandleFunc("/invoke", conn.Invoke)

	fmt.Println("Listening port 3000...")
	if err := http.ListenAndServe(":3000", nil); err != nil {
		fmt.Println(err)
	}
}
