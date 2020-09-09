package main

import (
	"{{.Name}}/configs"
	"{{.Name}}/internal/app/{{.Name}}"
	"gitlab.com/makeblock-go/log"
	"gitlab.com/makeblock-go/mysql"
	"gitlab.com/makeblock-go/redis"
	"os"
	"os/signal"
)

func main() {
	isProduction := configs.Env.ProjectEnv == configs.Prod
	log.SetUp(isProduction,
		log.Any("serverName", "{{.Name}}"))
	defer log.Sync()

	cnf := mysql.NewConfig(
		configs.Env.Mysql.User,
		configs.Env.Mysql.Pwd,
		configs.Env.Mysql.Host,
		configs.Env.Mysql.Port,
		configs.Env.Mysql.DBName,
		configs.Env.Mysql.Charset,
		!isProduction)
	mysql.Register(cnf)
	defer mysql.Close()

	redis.SetUp(
		configs.Env.Redis.Host,
		configs.Env.Redis.Port,
		configs.Env.Redis.Pwd)
	defer redis.Close()

	{{.Name}}.RunServer(":{{.Port}}")

	quit := make(chan os.Signal, 1)
	signal.Notify(quit, os.Interrupt)
	<-quit
	log.Println("Shutdown Server ...")
}
