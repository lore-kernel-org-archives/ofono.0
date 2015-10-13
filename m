Content-Type: multipart/mixed; boundary="===============1553268185402202804=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] hfp_ag_bluez5: add codec negotiation support
Date: Tue, 13 Oct 2015 09:36:15 -0500
Message-ID: <561D16DF.90103@gmail.com>
In-Reply-To: <561CD759.4090109@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1553268185402202804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On 10/13/2015 05:05 AM, Simon Fels wrote:
>> Do we really need this?  It might be simpler to just always support
>> codec negotiation if the AG emulator is created with version >=3D 1.6
>
> We can do that but then have to pass the HFP version we're going to run
> with ofono_emulator_create.
>

We don't really need to do that.  Just always enable codec negotiation =

support.  We register the SDP Record with version 1.7 anyway.  That is =

static and not a per-connection setting.

If the HF doesn't send as a AT+BAC during the SLC setup, then we don't =

do codec negotiation.

>> If you include drivers/atmodem/atutil.h you can skip this and...
>
> I thought about this before but that also requires me to include
> gatchat/gatresult.h and gatchat/gatchat.h ... Best would be we move
> those defines to a common place like src/common.h or so.
>

Ah, forgot the AG plugin doesn't use GAtChat.  Nevermind then.

>> Is calling this from inside g_idle_add really necessary?  card_connect
>> is using Non-Blocking connect anyway.
>
> The idea was to ensure that the OK always goes out first before we open
> the SCO connection. Will add a comment to make this a bit more visible.
>

GAtServer uses non-blocking writes, so you're not really guaranteeing it =

this way.  And the spec mentions no specific order either.

>
>> Any pending D-Bus requests might be never replied to here...  According
>> to the spec this situation is impossible, but still...
>
> We already replied at this point! There are two cases where we end up in
> bcs_cb.
>
> 1. We trigger codec negotiation from hfp16_card_connect with a call to
> ofono_emulator_start_codec_negotation. If that call succeeds we reply to
> org.ofono.HandsfreeAudioCard.Connect and also when it fails we do. We
> don't bind the success of the connect call here to the codec negotiation.
>

Yes, you're right.  I just re-read the implementation again.  However, =

I'm thinking that the D-Bus method should be replied to only after the =

SCO link has been opened / failed.

> 2. When the remote side sends us the AT+BCC command we start the codec
> negotiation and the same as mentioned in 1. applies.

In this case there's no D-Bus method.  The remote HF is asking for the =

codec connection.  In case we hit this condition the process simply stalls.

>
> However as I am thinking right now about this is not correct. The
> documentation of the org.ofono.HandsfreeAudioCard.Connect method says:
>
>   Attempts to establish the SCO audio connection.
>   The Agent NewConnection() method will be called
>   whenever the SCO audio link has been established.  If
>   the audio connection could not be established, this
>   method will return an error.
>
> So we have to wait for codec negotiation to finish before we can reply.
>

Agreed.

> Will fix that too.
>

Regards,
-Denis


--===============1553268185402202804==--

