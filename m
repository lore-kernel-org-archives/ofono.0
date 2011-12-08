Content-Type: multipart/mixed; boundary="===============4968841112433220778=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH_v0 1/6] doc: Add DormantInterval property
Date: Thu, 08 Dec 2011 10:25:03 +0100
Message-ID: <4EE0826F.50707@linux.intel.com>
In-Reply-To: <4EDF5D61.8080609@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4968841112433220778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 07/12/2011 13:34, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 12/07/2011 10:05 AM, Guillaume Zajac wrote:
>> ---
>>   doc/cdma-connman-api.txt |    5 +++++
>>   1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/doc/cdma-connman-api.txt b/doc/cdma-connman-api.txt
>> index 48699a3..a6d1e56 100644
>> --- a/doc/cdma-connman-api.txt
>> +++ b/doc/cdma-connman-api.txt
>> @@ -35,6 +35,11 @@ Properties	boolean Powered [readwrite]
>>   			Contains whether the connection is dormant.  Will
>>   			always be false if the connection is not powered.
>>
>> +		int DormantInterval [readwrite]
>> +
>> +			Contains the interval in seconds to enter in dormant
>> +			Mode.
>> +
> Why would the user want to mess with this setting? What would be the
> right interval?  Remember, oFono only exports settings that are useful
> to show to the user, and that the user can understand what to do with.
> This this one certainly doesn't fit the above description.
>
> Besides, we should simply disable dormancy mode in the first place.  The
> base station can more intelligently manage that anyway.
>

Right, the user can't manage this value, however Dormant property is =

ReadOnly.
So should we have a specific DBus API to disable/enable the dormancy mode?

Kind regards,
Guillaume

--===============4968841112433220778==--

