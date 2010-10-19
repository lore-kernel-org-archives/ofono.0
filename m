Content-Type: multipart/mixed; boundary="===============3469420601405548543=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Call Barring and MMI Supplementary Service codes
Date: Tue, 19 Oct 2010 10:11:49 -0500
Message-ID: <4CBDB535.7040708@gmail.com>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC702B72E8A@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3469420601405548543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rajesh,

On 10/19/2010 12:27 AM, Rajesh.Nagaiah(a)elektrobit.com wrote:
> Hi Denis, =

>  =

>> My interpretation of 22.004 and 22.030 was that dedicated =

>> packet access and dedicated PAD access were deprecated and no =

>> longer being used.  The fact that they're still listed in =

>> 27.007 seems to be irrelevant.
> =

> As dedicated packet access and dedicated PAD access is mentioned in
> 27.007, the AT modems still consider these values while translating the
> corresponding Basic Service group. Thats the reason when sending 16 the
> AT modem translates it to "All data circuit sync" and  80  to "All Sync
> services" in REGISTER message(Fred can you confirm this ?). =

> In case of message based modems, we have seperate MMI for All Sync
> services and All data circuit sync services and as MMI's for dedicated
> packet access and dedicated PAD access are deprecated the translation
> happens without conflict.

So let me repeat what you said in my own words.  The lowlevel register
message has these variations:

- All data circuit sync
- All sync services

- All data circuit async
- All async services

In both cases they actually refer to the same set of bearer services.
So sending one vs the other makes no difference.  So instead of
deprecating the 'all sync' and 'all async' versions of the low level
register messages the spec still expects us to send them for whatever
reason.  And the compliance tests are trying to ensure the modem sends
the 'right' one.  This is why we have to use values 64 and 128.

Am I right so far?

If so, on what planet is this not a bug in the test case? Oh right, this
is GSM...

Anyhow, this finally makes sense at least, in a twisted sort of way.

Regards,
-Denis

--===============3469420601405548543==--

