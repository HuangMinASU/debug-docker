package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
)

// handler 是一个简单的 HTTP 请求处理函数
func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, this is the Go service listening on port 8080!")
}

// postHandler 处理 POST 请求，打印接收到的 JSON 数据
func postHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodPost {
		body, err := ioutil.ReadAll(r.Body)
		if err != nil {
			http.Error(w, "Failed to read request body", http.StatusBadRequest)
			return
		}
		var data map[string]interface{}
		if err := json.Unmarshal(body, &data); err != nil {
			http.Error(w, "Failed to parse JSON", http.StatusBadRequest)
			return
		}
		fmt.Println("Received JSON data:", data)

		// 创建响应对象
		response := map[string]interface{}{
			"code": 200,
			"msg":  "success, me get json",
		}

		// 设置响应 header 的 content type 为 application/json
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK) // 设置状态码为200

		// 返回响应
		jsonResponse, err := json.Marshal(response)
		if err != nil {
			http.Error(w, "Failed to generate JSON response", http.StatusInternalServerError)
			return
		}
		w.Write(jsonResponse)

	} else {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
	}
}

// helloHandler 处理 GET 请求，返回“hello herry”
func helloHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodGet {
		fmt.Fprintf(w, "Hello, herry")
	} else {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
	}
}

func main() {
	// 将处理函数绑定到路由
	http.HandleFunc("/", handler)
	http.HandleFunc("/test", postHandler)
	http.HandleFunc("/hello", helloHandler)

	// 设置监听的端口并启动服务
	port := ":8080"
	fmt.Printf("Starting server on port %s\n", port)

	// ListenAndServe 使用指定的TCP地址和handler启动一个HTTP服务器
	// 第二个参数通常写nil表示使用DefaultServeMux
	err := http.ListenAndServe(port, nil)
	if err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}
