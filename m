Content-Type: multipart/mixed; boundary="===============4184310186383322668=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: Re: [PATCH] doc: Add modem Type property
Date: Fri, 21 Jan 2011 12:48:47 -0800
Message-ID: <4D39F12F.2040208@nokia.com>
In-Reply-To: <4D39E972.5060305@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4184310186383322668==
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

We understand that the decision during the CDMA workshop but as we =

explained one use case in the cover letter =

(http://lists.ofono.org/pipermail/ofono/2011-January/007890.html) for =

this RFC, there will be cases where atom's D-Bus I/F is not suitable (or =

as a reliable way) for telling what is current mode (CDMA or GSM). E.g., =

in the case of retrieving serial number from modem. Currently both CDMA =

and GSM shares the same I/F (ofono.org.modem) rather than having =

separate (ofono.org.cdma.modem). And, further if no other atom has been =

instantiated, then, there will be no other way to tell which mode (CDMA =

or GSM) the modem is. And, further for displaying serial number, upper =

layer will need to know it is CDMA or GSM. In case of CDMA, the serial =

number is MEID and GSM it is IMEI. As explained in cover letter, we =

anticipate more cases like this.

>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

Regards
Lei

--===============4184310186383322668==--

