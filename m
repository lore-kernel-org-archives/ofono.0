Content-Type: multipart/mixed; boundary="===============7215363708943706318=="
MIME-Version: 1.0
From: Joly, Frederic <frederic.joly@intel.com>
Subject: RE: [RFC PATCH] gprs: add function to handle activated context
Date: Fri, 07 Jan 2011 15:45:21 +0000
Message-ID: <129600E5E5FB004392DDC3FB599660D70106E0FFC1@irsmsx504.ger.corp.intel.com>
In-Reply-To: <201101071052.19202.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7215363708943706318==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



-----Original Message-----
From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behal=
f Of R=C3=A9mi Denis-Courmont
Sent: Friday, January 07, 2011 9:52 AM
To: ofono(a)ofono.org
Subject: Re: [RFC PATCH] gprs: add function to handle activated context

On Thursday 06 January 2011 02:17:09 ext Denis Kenzior, you wrote:
>> >> If such context is not found create a new one with "Internet" type.
>> > =

>> > I don't really agree that we should create a context if no match is
>> > found. I think the better sensible strategy is to hold this information
>> > internally and only map it to a context once the user or provisioning
>> > creates it.
>> =

>> From what I understood it should be quite safe to assume it is an
>> internet context.  All IMS contexts will have a well-known APN and the
>> only other one that would make sense for the network to activate
>> automatically would be the internet one.
>> =

>> Perhaps this is the missing piece in the description? The fact that
>> either the IMS or an Internet context is created.
>
>It could be MMS(/WAP) or it could be some private corporate VPN. Or it cou=
ld =

>even be some other silliness from some operator(s). I have seen such thing=
, =

>but I am unsure I can talk freely about the details :-(
>
>I would definitely advise against marking unknown context as Internets.

This makes sense.

In the case this context is resulting from a PDN connectivity Request piggy=
backed on an Attach Request, should we assume that that this initial contex=
t could be an MMS or a private corporate VPN related context?
My assumption would be that in this particular case that the context is an =
"internet" or an "IMS" context.

The reception of an MMS "push" over SMS on the circuit switched  domain cou=
ld provoke the attach, but I would guess in this case that:
a second context initiated by the UE is used specifically for the MMS
or
the PDN connectivity request includes a MMS APN with an ESM information tra=
nsfer flag to transfer securely the "login and password"  required to downl=
oad the MMS.  =


I can also hardly imagine that an initial bearer context being a "VPN" spec=
ific bearer.

But, maybe I'm wrong.

BR,

Fred  =






 =

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki
_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============7215363708943706318==--

