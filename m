Content-Type: multipart/mixed; boundary="===============8214771364582037212=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH_v0 1/5] doc: Add bearer property
Date: Mon, 05 Dec 2011 11:40:13 +0100
Message-ID: <4EDC9F8D.30107@linux.intel.com>
In-Reply-To: <4ED5F7AF.5050908@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8214771364582037212==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 30/11/2011 10:30, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 12/02/2011 08:00 AM, Guillaume Zajac wrote:
>> ---
>>   doc/cdma-connman-api.txt |    8 ++++++++
>>   1 files changed, 8 insertions(+), 0 deletions(-)
>>
>> diff --git a/doc/cdma-connman-api.txt b/doc/cdma-connman-api.txt
>> index 48699a3..bf1ec1e 100644
>> --- a/doc/cdma-connman-api.txt
>> +++ b/doc/cdma-connman-api.txt
>> @@ -35,6 +35,14 @@ Properties	boolean Powered [readwrite]
>>   			Contains whether the connection is dormant.  Will
>>   			always be false if the connection is not powered.
>>
>> +		string Bearer [readonly, optional]
>> +
>> +			Contains the data bearer technology as reported by the
>> +			service registration (if known).
>> +
>> +			Possible values are:
>> +			"none", "1x", "evdo", "svdo"
>> +
> The 1X and EVDO registration status is already handled by the
> NetworkRegistration interface (namely Strength for 1X and DataStrength
> for EV-DO).

As we propose this "bearer" property for GSM into connman-api.txt, why =

don't we for CDMA?
It would be easier to have same property in GSM and CDMA to recover the =

info at network panel level for instance to display technology used.

We have the same kind of information into network.c namely "technology", =

should we add this property also into cdma-netreg.c?
I saw it in a TODO into network-api.txt:
[...]
string Technology [readonly, optional]

             Contains the technology of the current network.

             The possible values are: "gsm", "edge", "umts", "hspa",
                             "lte"

             TODO: Values for CDMA and EVDO based networks.
[...]
We have to add the values into common.h, right?

> Whether we need an SVDO indicator is another question entirely, but it
> definitely does not belong in ConnectionManager.  All SVDO indicates is
> whether data + voice are possible simultaneously.
>

Can't we specify at least the technology?

Kind regards,
Guillaume


--===============8214771364582037212==--

