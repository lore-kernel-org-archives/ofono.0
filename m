Content-Type: multipart/mixed; boundary="===============2507306289665122536=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: Re: [PATCH] doc: Add modem Type property
Date: Thu, 03 Feb 2011 11:39:49 -0800
Message-ID: <4D4B0485.6070401@nokia.com>
In-Reply-To: <20110203192553.GC2168@joana>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2507306289665122536==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo

On 02/03/2011 11:25 AM, ext Gustavo F. Padovan wrote:
> Hi Dara,
>
> * Dara Spieker-Doyle<dara.spieker-doyle@nokia.com>  [2011-01-20 14:48:5=
7 -0800]:
>
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
>
> I think that this can also help with ConnMan, currently it enables all mo=
dems,
> even the hfp one, which is wrong.
>

Yes, this is what we suspect as well and had a discussion about it in =

the IRC recently. We are currently preparing a CDMA ConnMan patch to =

establish if it will further justify supporting this interface from a =

CDMA perspective.

Cheers
Dara

--===============2507306289665122536==--

