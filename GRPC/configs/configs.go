package configs

import (
	"log"

	"github.com/timest/env"
)

const (
	// Dev develop environment
	Dev string = "dev"
	// Test test environment
	Test string = "test"
	// Pre preview environment
	Pre string = "pre"
	// Prod production environment
	Prod string = "prod"
)

//Env configuration in environment
var Env *config

type config struct {
	ProjectEnv string `env:"PROJECT_ENV" default:"dev"`
	APIVersion string `env:"API_VERSION" default:"Commit ID"`
	Mysql      struct {
		Host    string `default:"120.25.31.149"`
		Port    string `default:"3306"`
		DBName  string `default:"{{.Name}}"`
		User    string `default:"root"`
		Pwd     string `default:"tEKIZtC0CXjg"`
		Charset string `default:"utf8mb4"`
	}
	Redis struct {
		Host   string `default:"120.78.51.14"`
		Port   string `default:"7000"`
		Pwd    string `default:""`
		Prefix string `default:"{{.Name}}|"`
	}
}

func init() {
	Env = new(config)
	env.IgnorePrefix()
	err := env.Fill(Env)
	log.Println(Env)
	if err != nil {
		panic(err)
	}
}
