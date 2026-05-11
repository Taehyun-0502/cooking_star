<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Fruitables - Vegetable Website Template</title>
        <link href="/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
        <link href="/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="/css/bootstrap.min.css" rel="stylesheet">
        <link href="/css/style.css" rel="stylesheet">
    </head>

    <body>
        <div class="container-fluid fixed-top">
            <div class="container px-0">
                <nav class="navbar navbar-light bg-white navbar-expand-xl">
                    <a href="/" class="navbar-brand"><h1 class="text-primary display-6">Fruitables</h1></a>
                    
                    <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                        <div class="navbar-nav mx-auto">
                            <a href="/" class="nav-item nav-link">Home</a>
                            <a href="/shop" class="nav-item nav-link">Shop</a>
                            <a href="/shop-detail" class="nav-item nav-link">Shop Detail</a>
                            <div class="nav-item dropdown">
                                <a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown">Pages</a>
                                <div class="dropdown-menu m-0 bg-secondary rounded-0">
                                    <a href="/cart" class="dropdown-item">Cart</a>
                                    <a href="/checkout" class="dropdown-item">Checkout</a>
                                    <a href="/testimonial" class="dropdown-item">Testimonial</a>
                                    <a href="/404" class="dropdown-item active">404 Page</a>
                                </div>
                            </div>
                            <a href="/contact" class="nav-item nav-link">Contact</a>
                        </div>
                        </div>
                </nav>
            </div>
        </div>

        <div class="container-fluid py-5">
            <div class="container py-5 text-center">
                <div class="row justify-content-center">
                    <div class="col-lg-6">
                        <i class="bi bi-exclamation-triangle display-1 text-secondary"></i>
                        <h1 class="display-1">404</h1>
                        <h1 class="mb-4">Page Not Found</h1>
                        <a class="btn border-secondary rounded-pill py-3 px-5" href="/">Go Back To Home</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5">
            <div class="container py-5">
                <div class="row g-5">
                    <div class="col-lg-3 col-md-6">
                        <div class="footer-item">
                            <h4 class="text-light mb-3">Contact</h4>
                            <p>Address: 1429 Netus Rd, NY 48247</p>
                            <img src="/img/payment.png" class="img-fluid" alt="Payment Methods">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>   

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="/lib/easing/easing.min.js"></script>
        <script src="/lib/waypoints/waypoints.min.js"></script>
        <script src="/lib/lightbox/js/lightbox.min.js"></script>
        <script src="/lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="/js/main.js"></script>
    </body>
</html>