Content-Type: multipart/mixed; boundary="===============1464584367653868811=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: Re: [RFC 1/1] doc: Add modem technology type property
Date: Thu, 20 Jan 2011 14:04:34 -0800
Message-ID: <4D38B172.2040600@nokia.com>
In-Reply-To: <1295559274.3873.299.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1464584367653868811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel

On 01/20/2011 01:34 PM, ext Marcel Holtmann wrote:
> Hi Dara,
>
>>   doc/modem-api.txt |   11 +++++++++++
>>   1 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/doc/modem-api.txt b/doc/modem-api.txt
>> index 45043b0..fe03833 100644
>> --- a/doc/modem-api.txt
>> +++ b/doc/modem-api.txt
>> @@ -82,6 +82,17 @@ Properties	boolean Powered [readwrite]
>>
>>   			This is usually obtained by using the +CGSN AT command.
>>
>> +		string TechnologyType [readonly, optional, experimental]
>> +
>> +			String representing the technology type of the current
>> +			modem device.
>> +
>> +			The possible values are:
>> +				"gsm" 	The 3GPP family of technologies
>> +					including gsm, edge, umts, hspa, lte.
>> +				"cdma"  The 3GPP2 family of technologies
>> +					including cdma 1x, evdo.
>
> I would just call this property "Type" and then we can also have a value
> for "hfp" in case it is a Bluetooth HFP modem.
>
Thanks - sounds good to me. I'll prepare a patch to reflect this for =

gsm/cdma types and assume the hfp type extension is future work.

Cheers
Dara

--===============1464584367653868811==--

