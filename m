Content-Type: multipart/mixed; boundary="===============7256640675911633727=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCHv2 4/4] doc: document power-event signals for quectel
 Hardware API
Date: Fri, 19 Jul 2019 14:25:51 +0200
Message-ID: <e42c054d-4021-d3ab-fe93-21bace1eb2f1@geanix.com>
In-Reply-To: <20190719110416.GA11224@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7256640675911633727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On 19/07/2019 13.04, Pavel Machek wrote:
> On Fri 2019-07-19 12:19:14, Martin Hundeb=C3=B8ll wrote:
>> ---
>>
>> Changes since v1:
>>   * new patch split out from PATCHv1 7/7
>>
>>   doc/quectel-hardware-api.txt | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/doc/quectel-hardware-api.txt b/doc/quectel-hardware-api.txt
>> index 6aafbfd8..411afcd1 100644
>> --- a/doc/quectel-hardware-api.txt
>> +++ b/doc/quectel-hardware-api.txt
>> @@ -10,6 +10,25 @@ Methods		array{string,variant} GetProperties
>>   			Returns hardware properties for the modem object. See
>>   			the properties section for available properties.
>>   =

>> +Signals		PowerDown(string reason)
>> +
>> +			This signal is emitted on gracefull shutdowns initiated
>> +			by the modem.
>> +
>> +			Possible reasons:
>> +				"LowPower"	The supply voltage is too low
>> +				"Normal"	The PWRKEY pin was asserted
>> +				"HighPower"	The supply voltage is too high
>> +
>> +		PowerWarning(string reason)
>> +
>> +			This signal is emitted when the modem detects its supply
>> +			voltage is close to its supported limits.
>> +
>> +			Possible reasons:
>> +				"LowPower"	The supply voltage is low
>> +				"HighPower"	The supply voltage is high
>> +
> =

> It is "high voltage" not "high power", so maybe it should be
> "HighVoltage" (etc?).
> =

> ("Low power" sounds like device entered powersaving mode).

Agreed. I'll spin another version soon'ish.

// Martin

--===============7256640675911633727==--

