Content-Type: multipart/mixed; boundary="===============4201817324776946902=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: Re: [PATCH] doc: Add modem Type property
Date: Fri, 21 Jan 2011 13:07:23 -0800
Message-ID: <4D39F58B.9080407@nokia.com>
In-Reply-To: <4D39E972.5060305@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4201817324776946902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 01/21/2011 12:15 PM, ext Denis Kenzior wrote:
> Hi Dara,
>
> On 01/20/2011 04:48 PM, Dara Spieker-Doyle wrote:
>> Add support for providing the type of the attached modem device
>> including GSM (3GPP), CDMA (3GPP2) and Bluetooth HFP.
>> ---
>>   doc/modem-api.txt |   13 +++++++++++++
>>   1 files changed, 13 insertions(+), 0 deletions(-)
>>
>> diff --git a/doc/modem-api.txt b/doc/modem-api.txt
>> index 45043b0..fe806c8 100644
>> --- a/doc/modem-api.txt
>> +++ b/doc/modem-api.txt
>> @@ -82,6 +82,19 @@ Properties	boolean Powered [readwrite]
>>
>>   			This is usually obtained by using the +CGSN AT command.
>>
>> +		string Type [readonly, optional, experimental]
>> +
>> +			String representing the type of the modem device.
>> +
>> +			The possible values are:
>> +				"gsm" 	Modem supports one or more of the 3GPP
>> +					family of technologies including GSM,
>> +					EDGE, UMTS, HSPA, LTE.
>> +				"cdma"  Modem supports one or more of the 3GPP2
>> +					family of technologies including CDMA 1x,
>> +					EVDO.
>> +				"hfp"	Bluetooth hands-free profile (HFP) modem
>> +
>
> So one pointed question:
>
> How are we planning to support dual-mode devices with this property?  I
> believe during the CDMA workshop we decided that the clients should
> simply look at the set of interfaces, not a semi-static property...

Also, it is my understanding that the reason we create org.ofono.cdma =

interfaces during CDMA workshop are to make sure CDMA interfaces and =

logics do not "pollute" GSM interfaces and logics which are very =

different anyway. We have not ruled out the case where there may be =

shared interfaces as we see a need. Currently, org.ofono.modem is this =

case. Unless we would go ahead creating org.ofono.cdma.modem, we =

discussed that option internally but feel that is less preferable than =

the "Type" property we proposed here.

>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

Regards,
-Lei


--===============4201817324776946902==--

