// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

contract mame {

    // ---Variabel Status ERC-20---

    // Nama Token : Mame Coin
    string public namaCoin = "Mame Coin";

    // Simbol Coin : MAME
    string public simbolCoin = "MAME";

    //Jumlah desimal Coin (standar 18, standar Ethereum)
    uint8 public jumlahDesimal = 18;

    //Total pasokan Coin yang ada
    uint256 public jumlahCoin;

    // Mapping untuk melacak saldo setiap alamat
        // Kunci: alamat pengguna (address)
        // Nilai: jumlah token yang dimiliki (uint256)
    mapping(address => uint256) public saldo;

    // Mapping bersarang untuk melacak izin pengeluaran (allowances)
        // Kunci 1: pemilik token (address)
        // Kunci 2: alamat yang diizinkan untuk membelanjakan (address)
        // Nilai: jumlah token yang diizinkan (uint256)
    mapping(address => mapping(address => uint256)) public izinPengeluaran;

    // ---Events ERC-20---

    // Muncul Notif setiap Coin di transfer
    event transfer(address indexed dari, address indexed ke, uint256 jumlah);

    // Muncul Notif setiap izin pengeluaran diupdate
    event izin(address indexed pemilik, address indexed pembelanja, uint256 jumlah);

    // ---Constructor---
    constructor() {

        // Tetapkan total pasokan Coin awal
        jumlahCoin = 1000000*(10**uint256(jumlahDesimal)); // 1 juta Coin

        // Berikan semua token awal kepada alamat yang mendeploy kontrak
        saldo[msg.sender] = jumlahCoin;

        // Muncul Notif Transfer untuk menandai pembuatan Coin awal
        emit transfer(address(0), msg.sender, jumlahCoin);


    }

    // Fitur-fitur
   
    // Periksa saldo Coin suatu alamat
    function cekSaldo(address akun) public view returns (uint256) {
        return saldo[akun];
    }

    // Mengirim token dari pemanggil fungsi ke 'penerima'
    function transferCoin(address penerima, uint256 jumlah) public returns (bool) {
        
        // Pastikan penerima bukan alamat nol
        require(penerima != address(0), "Admin : transfer ke alamat nol tidak diizinkan!");

        // Pastikan saldo pengirim cukup
        require(saldo[msg.sender] >= jumlah, "Admin : Saldo tidak cukup!");

        // Kurangi saldo pengirim
        saldo[msg.sender] -= jumlah;

        // Tambahkan saldo penerima
        saldo[penerima] += jumlah;

        // Muncul Notif Transfer
        emit transfer(msg.sender, penerima, jumlah);

        return true; // Berhasil transfer

    }

    // Izin akses untuk mengirim
    function izinMinta(address pembelanja, uint256 jumlah) public returns (bool) {

        // Pastikan pembelanja bukana alamat nol
         require(pembelanja != address(0), "Admin : izin ke alamat nol tidak diizinkan!");

         // Update izin di mapping izinPengeluaran
         izinPengeluaran[msg.sender][pembelanja] = jumlah;

         // Muncul Notif Izin
         emit izin(msg.sender, pembelanja, jumlah);

         return true;
    }

    // Banyaknya Coin yang diizinkan untuk dibelanjakan
    function jumlahMinta(address pemilik, address penerima) public view returns (uint256) {
        return izinPengeluaran[pemilik][penerima];
    }

    // Di transfer dari-
    function mintaDari(address pengirim, address penerima, uint256 dikirim) public returns (bool){

        //REQUIREMENT
        // Pastikan pengirim bukan alamat nol
        require (pengirim != address(0), "Admin : transfer dari alamat nol tidak diizinkan!");

        // Pastikan penerima bukan alamat nol
        require (penerima != address(0), "Admin : transfer ke alamat nol tidak diizinkan");

        // Pastikan saldo pengirim cukup
        require (saldo[pengirim] >= dikirim, "Admin : saldo anda tidak cukup!");

        // Pastikan msg.sender memiliki izin yang cukup dari pengirim
        require (izinPengeluaran[pengirim][msg.sender] >= dikirim, "Admin : izin tidak cukup");

        //Fitur
        // Kurangi izin yang digunakan
        izinPengeluaran[pengirim][msg.sender] -= dikirim;

        // Kurangi saldo pengirim
        saldo[pengirim] -= dikirim;

        // Tambahkan saldo penerima
        saldo[penerima] += dikirim;

        // Muncul Notif Transfer
        emit transfer(pengirim, penerima, dikirim);

        return true;
    }

}