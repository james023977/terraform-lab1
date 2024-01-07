必須先在GCP Console網頁裡，啟動會使用的到的API服務(如cloud DNS、static IP address等)，可參考岳韋的GCP建制截圖。
在variable.tf變數檔裡，可設定、修改default = "OOXX"岳韋提供的參數。
我使用 "terraform plan -out plan.out"

