Content-Type: multipart/mixed; boundary="===============6993162175813270918=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 2/4] stk: Handle Launch Browser proactive command
Date: Thu, 13 Jan 2011 10:35:46 -0600
Message-ID: <4D2F29E2.403@gmail.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802D5A07B@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6993162175813270918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 01/13/2011 08:56 AM, Jeevaka.Badrappan(a)elektrobit.com wrote:
> Hi,
> =

>>>
>>> So a question about this.  Why are we checking the netreg atom?
>>> Shouldn't we be checking the gprs atom's attached property?  But this
>>> brings up an even more interesting question, do we even need to
>>> assume that we have to be attached to the cellular network to
>>> perform these operations?  We could in theory go over wifi.
>>
>> I agree that the modem online property is unrelated to this.
>> Also the card may in theory specify a URL that designates a
>> local file or something on a local network, not the internet.
>>
> =

> Agree. It can be anything not only cellular network. Do we need
> to check the bearer parameters in that case or can I just remove the
> current check code?

Good point on the bearer parameters.  My take is that we should either
ignore the bearer parameters or return not-capable if they're set.
Otherwise removing the current checks in the code seems reasonable to me.

Regards,
-Denis

--===============6993162175813270918==--

