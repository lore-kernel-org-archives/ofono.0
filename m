Content-Type: multipart/mixed; boundary="===============4352935564124396909=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC at-export 2/2] ublox: network-registration atom
Date: Thu, 16 May 2019 11:01:53 -0500
Message-ID: <9aabfacb-6de4-6b7f-8a8a-a946c99d21b0@gmail.com>
In-Reply-To: <CAHB-PjmrG9QdsyX3dECdqkLw6e_ko4LFy5PPH8YMM=yU2kJr1w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4352935564124396909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

>> So I think there's a bug where we erroneously set the Attached property
>> to False in this situation.  It doesn't look like we trigger an actual
>> detach, but Attached should remain 'True' while CREG shows that we're on
>> EUTRAN or any related tech.  Perhaps the logic in gprs_attached_update()
>> needs to be updated.
> =

> We need to consider the "tricky" part that we consider us attached
> first when the
>   context is activated in EUTRAN. And we might be in a transition
> (attaching flag).

Which is why the whole 'separate context state into a bazillion =

commands' is just inherently a bad idea on 3GPP's part.  It makes it =

hard to figure out wtf just happened in an atomic way.

I think we already have some magic where we only signal Attached once =

the default bearer settings are read, e.g. after .read_settings =

completes successfully.  The second part will be tricky...

> =

> I'm thinking if the "combined" state in gprs wouldn't be the least
> intrusive update for this.
> =

> I think I saw a patch for using c*reg in atmodem/gprs.c, can we wake that=
 up?
> Otherwise I can put some energy into this, if we decide which
> direction to go first.
> =


Since 3GPP decided to go with EREG being separate from CGREG, I think it =

makes sense to support that natively in lte.c or gprs.c.  Our philosophy =

has always been to base the driver APIs off of 27.007.  So from that =

perspective, introducing ofono_lte_status_notify would make sense. =

Whether something like this makes things easier or not is a different =

question :)

Regards,
-Denis

--===============4352935564124396909==--

