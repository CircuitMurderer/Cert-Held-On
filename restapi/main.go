package main

import (
	"SEIUN/restapi/web"
	"fmt"
)

func main() {
	conn, err := web.NewConnectorFrom("conf.yaml")
	if err != nil {
		fmt.Println("Something went wrong: ", err)
	}

	web.Serve(web.Connector(*conn))
}