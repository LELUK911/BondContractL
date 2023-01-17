- V)  Deposit and withdraw function  and countability for this function
- 2)  Creation Bond
     - V) Data storage structure
     - V) function Create Bond 
        - v) Function deposit collateral
        - v) function minter Nft(bond) for sell to users
- 3) Function deposit Interests to paid user at expiration
     - a) function withdraw interests from loans's users
     - b) function liquidation collateral when issuing bond don't paid  interests to users
     - c) function burn bond(nft)at expired time, user can withdraw your initial deposit
        - a) function liquidation all collateral if at expired debt , issuing deposit don't will cover debt.
- 4) Withdraw deposit when Nft(bond) burned.





- da fare prima di proseguire
        - 1) terminare contratto ERC721
        - 2) sostituire il contratto ERC1155 con ERC721
        - 3) verificare test gia fatti
        - 4) completare la funzione di "claim Coupon expire"