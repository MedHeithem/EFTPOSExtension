codeunit 90102 ETF_Pos_Codeunit
{
    trigger OnRun()
    begin

    end;



    procedure ExecuteETFPOS(pSlipNo: Text; pClientID: Text; pCurrencyCode: Code[10]; pAmount: Decimal; pCashBack: Decimal; pVat: Decimal; pCustomData: Text; pStore: Code[20]; pTerminal: Code[20]) Result: Option
    var

        amountToEft: Record "Amout TO EFT";


    begin
        Result := amountToEft.Satus::Fail;
        if (pAmount < 100000) then begin
            amountToEft.InsertData(pSlipNo, pClientID, pCurrencyCode, pAmount, pCashBack, pVat, pCustomData, pStore, pTerminal);
            Commit();
            Sleep(1000);
            Hyperlink('http://localhost:84/run.htm');

            //ajouter loader()
            if Dialog.Confirm('Operation Terminée?', true) then; // begin


            amountToEft.Reset();
            amountToEft.SetFilter(SlipNo, pSlipNo);
            amountToEft.SetFilter(ClientID, pClientID);
            if amountToEft.FindLast() then
                Result := amountToEft.Satus;

            // Message('%1', amountToEft.Satus);

            //end;
            CloseETFPOS();

        end
        else
            Message('%1 DT:Dépassement du montant autorisé!. basculez vers la carte bancaire manuelle', pAmount);



    end;


    procedure CloseETFPOS() Result: Text
    var



        repdll: DotNet REP;
    begin
        Result := repdll.EFTPOS().KillETFPOSProcessus();



    end;




}
dotnet
{
    assembly(EFTPOSRetail)
    {
        type(EFTPOSRetail.EFTPOS; REP) { }
    }
}