page 50100 "Amount to EFT"
{
    ApplicationArea = All;
    Caption = 'Amount to EFT';
    PageType = List;
    SourceTable = "Amout TO EFT";
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(CashBack; Rec.CashBack)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CashBack field.';
                }
                field(ClientID; Rec.ClientID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ClientID field.';
                }
                field(CurrencyCode; Rec.CurrencyCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CurrencyCode field.';
                }
                field(CustomData; Rec.CustomData)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CustomData field.';
                }
                field("DateTime"; Rec."DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the DateTime field.';
                }
                field(EntryNo; Rec.EntryNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EntryNo field.';
                }
                field("POS Terminal No."; Rec."POS Terminal No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the POS Terminal No. field.';
                }
                field(Reponse; Rec.Reponse)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reponse field.';
                }
                field(Satus; Rec.Satus)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Satus field.';
                }
                field(SlipNo; Rec.SlipNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SlipNo field.';
                }
                field("Store No."; Rec."Store No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Store No. field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                field(Vat; Rec.Vat)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vat field.';
                }
            }
        }
    }
}
