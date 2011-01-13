Content-Type: multipart/mixed; boundary="===============0340078905060183332=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 5/5] doc: Describe TextTelephony property
Date: Wed, 12 Jan 2011 23:20:41 -0600
Message-ID: <4D2E8BA9.4070809@gmail.com>
In-Reply-To: <1294812055.3873.51.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0340078905060183332==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 01/12/2011 12:00 AM, Marcel Holtmann wrote:
> Hi Jeevaka,
> =

>>  doc/voicecall-api.txt |    7 +++++++
>>  1 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
>> index 4f38e6a..8df8fd2 100644
>> --- a/doc/voicecall-api.txt
>> +++ b/doc/voicecall-api.txt
>> @@ -100,6 +100,13 @@ Properties	string LineIdentification [readonly]
>>  			Notifications if a call becomes part or leaves a
>>  			multipart call are sent.
>>  =

>> +		boolean TextTelephony [readonly]
>> +
>> +			Contains the indication if the voice call is a
>> +			text telephony call or not.
>> +
>> +			Notifications if a call is a text telephony call.
>> +
>>  		string State [readonly]
>>  =

>>  			Contains the state of the current call.  The state
> =

> I am fine with actually.
> =

> Denis, any objections?
> =


Based on what I have heard so far, this seems fine.  However see my
concern in my reply to the IFX driver patch.

Regards,
-Denis

--===============0340078905060183332==--

