function myFunction(arguments) {
    const mp = new MercadoPago('TEST-a7757571-4d50-4bad-bf8c-140067871527');
    const bricksBuilder = mp.bricks();
    mp.bricks().create("wallet", "wallet_container", {
        initialization: {
            preferenceId: arguments,
        },
     });
  }