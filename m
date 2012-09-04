Content-Type: multipart/mixed; boundary="===============9207830673085188143=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: Re: [PATCH 12/12] doc: Add ReportChanged signal description
Date: Tue, 04 Sep 2012 17:26:34 +0200
Message-ID: <50461DAA.2090602@linux.intel.com>
In-Reply-To: <503CD5E0.7030701@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9207830673085188143==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 08/28/2012 04:29 PM, Denis Kenzior wrote:
> Hi Ronald,
>
> On 08/24/2012 08:06 AM, Ronald Tessier wrote:
>> ---
>>   doc/message-api.txt |    7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>
> Please order any D-Bus API changes before the D-Bus API implementations.
>   E.g. this patch should be #10 in your series.
>
>> diff --git a/doc/message-api.txt b/doc/message-api.txt
>> index 2922e5d..274bb98 100644
>> --- a/doc/message-api.txt
>> +++ b/doc/message-api.txt
>> @@ -31,6 +31,13 @@ Signals        PropertyChanged(string name, variant
>> value)
>>               The only expected property change is for the
>>               message status.
>>
>> +        ReportChanged(string type, variant recipient, variant status)
>> +
>> +            Signal that is sent when a report has been received and
>> +            processed. It contains the type of the report
>> +            ("delivery_report" or other), the recipient concerned
>> +            and its new status.
>> +
>
> Why are we not simply changing the 'Status' to delivered/expired, etc?

Unfortunately, we cannot use the message status because there is one =

delivery status per recipient (a message can be sent to 2 (or more) =

recipients, so it can be delivered to one of them and "not yet =

delivered" to the other one).

Regards,

Ronald


--===============9207830673085188143==--

