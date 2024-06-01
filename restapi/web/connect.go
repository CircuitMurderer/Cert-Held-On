package web

import (
	"crypto/x509"
	"fmt"
	"os"
	"path"

	"github.com/hyperledger/fabric-gateway/pkg/client"
	"github.com/hyperledger/fabric-gateway/pkg/identity"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials"
	"gopkg.in/yaml.v3"
)

type ConnectConfig struct {
	OrgName     string `yaml:"orgName"`
	MspID       string `yaml:"mspID"`
	CryptoPath  string `yaml:"cryptoPath"`
	CertPath    string `yaml:"certPath"`
	KeyPath     string `yaml:"keyPath"`
	TlsCertPath string `yaml:"tlsCertPath"`
	PeerPoint   string `yaml:"peerPoint"`
	GatewayPeer string `yaml:"gatewayPeer"`
	Channel     string `yaml:"channel"`
	CcType      string `yaml:"ccType"`
}

type Connector struct {
	Config  *ConnectConfig
	Gateway *client.Gateway
}

func createConnFrom(filePath string) (*Connector, error) {
	data, err := os.ReadFile(filePath)
	if err != nil {
		return nil, err
	}

	c := ConnectConfig{}
	err = yaml.Unmarshal(data, &c)
	if err != nil {
		return nil, err
	}

	c.CertPath = c.CryptoPath + c.CertPath
	c.KeyPath = c.CryptoPath + c.KeyPath
	c.TlsCertPath = c.CryptoPath + c.TlsCertPath

	conn := Connector{}
	conn.Config = &c
	conn.Gateway = nil

	return &conn, nil
}

func loadCert(filePath string) (*x509.Certificate, error) {
	certPEM, err := os.ReadFile(filePath)
	if err != nil {
		return nil, fmt.Errorf("failed to read cert: %v", err)
	}
	return identity.CertificateFromPEM(certPEM)
}

func (c *Connector) createConnect() *grpc.ClientConn {
	cert, err := loadCert(c.Config.TlsCertPath)
	if err != nil {
		panic(err)
	}

	certPool := x509.NewCertPool()
	certPool.AddCert(cert)
	tpCred := credentials.NewClientTLSFromCert(certPool, c.Config.GatewayPeer)

	conn, err := grpc.Dial(c.Config.PeerPoint, grpc.WithTransportCredentials(tpCred))
	if err != nil {
		panic(fmt.Errorf("failed to create connection: %v", err))
	}

	return conn
}

func (c *Connector) createID() *identity.X509Identity {
	cert, err := loadCert(c.Config.CertPath)
	if err != nil {
		panic(err)
	}

	id, err := identity.NewX509Identity(c.Config.MspID, cert)
	if err != nil {
		panic(err)
	}

	return id
}

func (c *Connector) createSign() identity.Sign {
	files, err := os.ReadDir(c.Config.KeyPath)
	if err != nil {
		panic(fmt.Errorf("failed to read key dir: %v", err))
	}

	pKeyPEM, err := os.ReadFile(path.Join(c.Config.KeyPath, files[0].Name()))
	if err != nil {
		panic(fmt.Errorf("failed to read key file: %v", err))
	}

	pKey, err := identity.PrivateKeyFromPEM(pKeyPEM)
	if err != nil {
		panic(err)
	}

	sign, err := identity.NewPrivateKeySign(pKey)
	if err != nil {
		panic(err)
	}

	return sign
}
