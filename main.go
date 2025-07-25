package main

import (
	"fmt"
	"log"
	"net/http"
)

// handler 是一个简单的 HTTP 请求处理函数
func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, this is the Go service listening on port 2345!")
}

func main() {
	// 将处理函数绑定到路由
	http.HandleFunc("/", handler)

	// 设置监听的端口并启动服务
	port := ":2345"
	fmt.Printf("Starting server on port %s\n", port)
	
	// ListenAndServe 使用指定的TCP地址和handler启动一个HTTP服务器
	// 第二个参数通常写nil表示使用DefaultServeMux
	err := http.ListenAndServe(port, nil)
	if err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}
