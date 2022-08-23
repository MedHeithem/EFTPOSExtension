codeunit 90103 "SubscriberTest"
{
    EventSubscriberInstance = StaticAutomatic;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Transaction Events", 'OnBeforeInsertPayment_TenderKeyExecutedEx', '', true, true)]
    procedure OnBeforeInsertPayment(var POSTransaction: Record "LSC POS Transaction";
    var POSTransLine: Record "LSC POS Trans. Line";
    var CurrInput: Text;
    var TenderTypeCode: Code[10];
    var TenderAmountText: Text)
    begin
        if POSTransaction.EFTTransaction = true then
            TenderTypeCode := '3';
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Transaction Events", 'OnBeforeInsertPaymentLine', '', true, true)]
    procedure onBeforeInsertPline(var POSTransaction: Record "LSC POS Transaction"; var POSTransLine: Record "LSC POS Trans. Line"; var CurrInput: Text; var TenderTypeCode: Code[10]; Balance: decimal; PaymentAmount: Decimal; STATE: Code[10]; var isHandled: Boolean)
    begin
        if POSTransaction.EFTTransaction = true then
            TenderTypeCode := '3';

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Transaction Events", 'OnBeforeTransactionTendered', '', true, true)]

    procedure OnBeforeTransaction(var POSTransaction: Record "LSC POS Transaction";
       var TenderType: Record "LSC Tender Type";
       var VoidInProcess: Boolean;
       var Balance: Decimal)
    begin


    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Transaction Events", 'OnAfterTenderKeyPressedEx', '', true, true)]

    procedure TestTenderPress(var POSTransaction: Record "LSC POS Transaction";
    var POSTransLine: Record "LSC POS Trans. Line";
    var CurrInput: Text;
    var TenderTypeCode: Code[10];
    var TenderAmountText: Text;
    var IsHandled: Boolean)
    begin

        //Message(TenderTypeCode);
        if TenderTypeCode = '3' then begin
            ExecutedResult := ETFPOSC.ExecuteETFPOS(POSTransaction."Receipt No.", POSTransaction."Staff ID", 'TND', POSTransaction."Gross Amount", 0, 0, '', POSTransaction."Store No.", POSTransaction."POS Terminal No.");


            if (ExecutedResult = amouttoEtfTable.Satus::Appouved) then begin

                TenderAmountText := format(POSTransaction."Gross Amount");
                TenderTypeCode := '1';
                POSTransaction.EFTTransaction := true;  // ajout table ex POSTransaction + ajout colonne flag
                POSTransaction.Modify();
            end
            else begin
                message('transaction échouée');
                TenderTypeCode := '14';
                exit;
            end;

            ETFPOSC.CloseETFPOS();
            //OnBeforeTransaction(POSTransaction,TenderTypeCode,true,TenderAmountText);
        end;
    end;

    var
        ETFPOSC: Codeunit ETF_Pos_Codeunit;
        ExecutedResult: Option;
        amouttoEtfTable: Record "Amout TO EFT";



}
