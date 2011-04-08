Content-Type: multipart/mixed; boundary="===============4896496133816704939=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/6] stk-api.txt. Introduce the new API ConfirmOpenChannel
Date: Fri, 08 Apr 2011 11:59:57 -0500
Message-ID: <4D9F3F0D.3070608@gmail.com>
In-Reply-To: <1302280599.2572.202.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4896496133816704939==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 04/08/2011 11:36 AM, Marcel Holtmann wrote:
> Hi Philippe,
> =

>>  doc/stk-api.txt |    7 +++++++
>>  1 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/doc/stk-api.txt b/doc/stk-api.txt
>> index 0bcc6b5..aaa9fba 100644
>> --- a/doc/stk-api.txt
>> +++ b/doc/stk-api.txt
>> @@ -278,6 +278,13 @@ Methods		byte RequestSelection(string title, byte i=
con_id,
>>  =

>>  			Possible Errors: [service].Error.SimToolkit.EndSession
>>  =

>> +		boolean ConfirmOpenChannel(string information, byte icon_id)
>> +
>> +			Asks the agent to request user to confirm the channel
>> +			set-up.
>> +
>> +			Possible Errors: [service].Error.SimToolkit.EndSession
>> +
> =

> we need to talk a bit about these boolean return parameters for
> confirmation. Since essentially a positive D-Bus reply can be considered
> as TRUE and a D-Bus error as FALSE. So this essentially implicit.
> =

> You can not return FALSE and an error. That is not how D-Bus works.

Actually I'm fine with this.  The error has a different intent.

There are three potential outcomes of this operation:

- User accepts (True)
- User Rejects (False)
- User decides to end the session, which in addition to rejecting the
command as above, also reboots the STK session.

Unless you want to introduce org.ofono.Error.SimToolkit.UserRejected,
which to me looks ugly.

Regards,
-Denis

--===============4896496133816704939==--

