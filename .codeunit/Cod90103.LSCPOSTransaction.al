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
        if POSTransaction.EFTTransaction = 'CB' then
            TenderTypeCode := '3';
        if POSTransaction.EFTTransaction = 'CBM' then
            TenderTypeCode := '14';
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Transaction Events", 'OnBeforeInsertPaymentLine', '', true, true)]
    procedure onBeforeInsertPline(var POSTransaction: Record "LSC POS Transaction"; var POSTransLine: Record "LSC POS Trans. Line"; var CurrInput: Text; var TenderTypeCode: Code[10]; Balance: decimal; PaymentAmount: Decimal; STATE: Code[10]; var isHandled: Boolean)
    begin
        if POSTransaction.EFTTransaction = 'CB' then
            TenderTypeCode := '3';
        if POSTransaction.EFTTransaction = 'CBM' then
            TenderTypeCode := '14';

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
                POSTransaction.EFTTransaction := 'CB';  // ajout table ex POSTransaction + ajout colonne flag
                POSTransaction.Modify();
            end
            else begin
                message('transaction échouée');
                TenderTypeCode := '9';
                exit;
            end;

            ETFPOSC.CloseETFPOS();
            //OnBeforeTransaction(POSTransaction,TenderTypeCode,true,TenderAmountText);
        end;
        if TenderTypeCode = '14' then begin
            // ExecutedResult := ETFPOSC.ExecuteETFPOS(POSTransaction."Receipt No.", POSTransaction."Staff ID", 'TND', POSTransaction."Gross Amount", 0, 0, '', POSTransaction."Store No.", POSTransaction."POS Terminal No.");


            if Dialog.Confirm('paiement par carte bancaire manuelle. Veuillez continuer?', true) then begin // begin then begin

                TenderAmountText := format(POSTransaction."Gross Amount");
                TenderTypeCode := '1';
                POSTransaction.EFTTransaction := 'CBM';  // ajout table ex POSTransaction + ajout colonne flag
                POSTransaction.Modify();
            end;
        end
        else begin
            message('Opération annulée');
            TenderTypeCode := '9';

            exit;
        end;

        ETFPOSC.CloseETFPOS();
        //OnBeforeTransaction(POSTransaction,TenderTypeCode,true,TenderAmountText);

    end;

    var
        ETFPOSC: Codeunit ETF_Pos_Codeunit;
        ExecutedResult: Option;
        amouttoEtfTable: Record "Amout TO EFT";



}
