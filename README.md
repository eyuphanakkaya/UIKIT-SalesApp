# UIKIT-SalesApp

Swift ve UIKit kullanarak oluşturduğunuz uygulamanızın temel özellikleri arasında Firebase kullanarak giriş yapma, kaydolma ve çıkış yapma işlemleri bulunmaktadır. Ayrıca şifresini unutan kullanıcılar için Firebase üzerinden doğrulama ile şifre sıfırlama seçeneği sunuyorve Google ile giriş yapmak isteyen kullanıcılar da uygulamanıza kolayca erişebiliyorlar. Uygulama yapısında MVVM (Model-View-ViewModel) desenini tercih ettiğim.Ayrıca giriş yapan kullanıcının anlık konumunu alıyor ve böylece sipariş esnasında sıkıntı yaşanmıyor.

Giriş yapan kullanıcılar ayrıca Web API kullanarak ürünleri arama, sepete ekleme ve favorilere ekleme gibi işlemler gerçekleştirebiliyorlar.

Uygulamanızın temel özelliklerini gözden geçirelim:

1. **Giriş ve Kayıt İşlemleri**:
   - Kullanıcılar uygulamaya Firebase kullanarak giriş yapabilirler.
   - Yeni kullanıcılar kayıt olabilirler.
   - Şifresini unutan kullanıcılar Firebase doğrulama ile şifrelerini sıfırlayabilirler.

2. **Google İle Giriş**:
   - Kullanıcılar Google hesapları ile uygulamaya kolayca giriş yapabilirler.

3. **MVVM Deseni**:
   - Uygulamanızda Model-View-ViewModel desenini kullanarak kodları düzenlemişsiniz. Bu, uygulamanızın daha düzenli ve sürdürülebilir olmasına yardımcı olur.

4. **Ürün İşlemleri**:
   - Giriş yapmış kullanıcılar Web API aracılığıyla ürünleri arayabilirler.
   - Ürünleri sepete ekleyebilirler.
   - Ürünleri favorilere ekleyebilirler.

<img width="371" alt="Ekran Resmi 2023-09-04 15 24 12" src="https://github.com/eyuphanakkaya/UIKIT-SalesApp/assets/96181594/15dc5817-b30d-4242-a8ea-4dcc4a104f9a">
<img width="371" alt="Ekran Resmi 2023-09-04 15 25 29" src="https://github.com/eyuphanakkaya/UIKIT-SalesApp/assets/96181594/ab9bebb4-93fd-4776-9e87-5c4c30556668">
<img width="371" alt="Ekran Resmi 2023-09-04 15 25 56" src="https://github.com/eyuphanakkaya/UIKIT-SalesApp/assets/96181594/0ce588c1-7fa4-4215-8d96-b11dc6889c92">
<img width="371" alt="Ekran Resmi 2023-09-04 15 26 11" src="https://github.com/eyuphanakkaya/UIKIT-SalesApp/assets/96181594/7a1d96af-ced1-442c-961d-f301011bb0b3">
<img width="371" alt="Ekran Resmi 2023-09-04 15 26 21" src="https://github.com/eyuphanakkaya/UIKIT-SalesApp/assets/96181594/3841359d-0e14-493e-ac4f-046c22957814">
<img width="371" alt="Ekran Resmi 2023-09-04 15 26 52" src="https://github.com/eyuphanakkaya/UIKIT-SalesApp/assets/96181594/d2f671cf-fcf9-4200-92fb-471217a1ed4c">
<img width="371" alt="Ekran Resmi 2023-09-04 15 27 52" src="https://github.com/eyuphanakkaya/UIKIT-SalesApp/assets/96181594/785a2951-0cc6-48f0-b61f-b8832b6e31e2">
<img width="371" alt="Ekran Resmi 2023-09-04 15 28 17" src="https://github.com/eyuphanakkaya/UIKIT-SalesApp/assets/96181594/59e3705b-3fe6-40c0-a231-538221b68bcb">
