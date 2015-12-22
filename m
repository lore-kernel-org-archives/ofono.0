Content-Type: multipart/mixed; boundary="===============7398966216803169401=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: Re: [PATCH] network: Fix use-after-free caused by Scan() in poor
 reception.
Date: Tue, 22 Dec 2015 07:09:14 +0000
Message-ID: <5678F735.9000002@actia.se>
In-Reply-To: <56789513.70207@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7398966216803169401==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dennis,

On 12/22/2015 01:10 AM, Denis Kenzior wrote:
> Hi John,
>
> On 12/21/2015 04:03 AM, John Ernberg wrote:
>> From: John Ernberg <john.ernberg@actia.se>
>>
>> When issuing a Scan() in poor reception while attached to an operator =

>> it's
>> fully possible to get no results, which causes the attached operator =

>> to be
>> cleaned up. In certain scenarios this would cause a use-after-free.
>> Make sure to clean up all the references to the operator when it's =

>> destroyed.
>> ---
>>   src/network.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/src/network.c b/src/network.c
>> index 1dddcac..5329c28 100644
>> --- a/src/network.c
>> +++ b/src/network.c
>> @@ -257,6 +257,9 @@ static void network_operator_destroy(gpointer =

>> user_data)
>>   {
>>       struct network_operator_data *op =3D user_data;
>>
>> +    if (op->netreg->current_operator =3D=3D op)
>> +        op->netreg->current_operator =3D NULL;
>> +
>
> I'm not sure this is the right fix.  This will result in subsequent =

> API calls to return inconsistent information related to the network =

> operator.  For example, NetworkRegistration.Name, =

> NetworkRegistration.MobileNetworkCode, =

> NetworkRegistration.MobileCountryCode will be omitted.
>
> Can we make sure that the current operator is not destroyed / =

> unregistered in this particular situation?
It may be possible but I could not figure out a way to do that. So I did =

it like this to at least prevent the resulting SIGSEGV.
>
>>       g_free(op);
>>   }
>>
>>
>
> Regards,
> -Denis
Best regards // John Ernberg
--===============7398966216803169401==--

