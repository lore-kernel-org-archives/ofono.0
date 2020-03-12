Content-Type: multipart/mixed; boundary="===============5819791029082309188=="
MIME-Version: 1.0
From: Tarmo Kuuse <tarmo.kuuse@gmail.com>
Subject: Re: [PATCH] plugin: provision: create multiple contexts for multiple
 entries in mbpi
Date: Thu, 12 Mar 2020 21:36:26 +0200
Message-ID: <50960623-ace4-5fac-c30c-7c004b12eb8f@gmail.com>
In-Reply-To: <59c61ecf-9d98-90f2-a2f3-0ec8c09f6843@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5819791029082309188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 12.03.20 16:49, Denis Kenzior wrote:
> Hi Tarmo,
> =

>> I don't see how am I going to solve this. The end user cannot =

>> configure the device (there's no user interaction whatsoever). I could =

>> not find the mythical Android database at the time (I do now - it's at =

>> https://android.googlesource.com/device/sample/+/master/etc/apns-full-co=
nf.xml). =

>> It contains many duplicates, because the virtual MNO-s share MCC and =

>> MNC-s with the physical ones. That's how the mobile networks are built =

>> in the real world. So I was very confused about how to proceed.
> =

> MVNOs are handled by utilizing the EFspn file as a differentiator.=C2=A0 =
So =

> even if MNC/MCC is the same, once you include the SPN, the number of =

> duplicates goes down drastically.=C2=A0 This is why oFono uses the follow=
ing =

> signature for get_settings:
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*get_settings)(const cha=
r *mcc, const char *mnc, const =

> char *spn,
> =

> Once a proper database is used, this mostly goes away as an issue.=C2=A0 =
We =

> did add the SPN field to MBPI schema in the olden days.=C2=A0 The problem=
 is =

> that nobody actually updated the MBPI database to take advantage of this.

So if the SPN for every duplicate in mbpi was populated, ofono would =

start provisioning them? That's useful information. Where could one find =

the details of this schema documented?

>> Sure, after much, much frustration I arrived to the workaround of =

>> manually provisioning APNs (which I stole from mbpi!) for each factory =

>> installed SIM through Christophe Ronco's file-provision plugin. This =

>> plugin is a life-saver, but it certainly falls short of automatic =

>> provisioning. That's the same level of sophistication as pppd. And as =

>> extra punishment I have to write a network supervisor which orders =

>> connman to actually use the service of a new SIM whenever it is =

>> replaced - even if it's from the same MNO. But that's a different rant =

>> altogether.
>>
>> So, for perspective - saying "mbpi is just not a very good database" =

>> helps me none at all when I need to get my widget to go online :) =

>> Please handle the duplication, as this is how the mobile networks are =

>> built.
>>
> =

> I can take a patch that enables duplicates as a config / environmental =

> setting.=C2=A0 As long as the default is the old behavior.=C2=A0 But as I =

> mentioned previously, ConnMan / oFono were not designed to work this =

> way, and so far nobody has been willing to do the work in both projects =

> to change that.

I emphasize.

Stepping back, I suspect the task of maintaining a clean, accurate =

provisioning database of every SIM in the world is rather challenging. =

Perhaps more challenging, than re-designing ofono :)

I could pick up a few commodity SIMs from my country, determine the SPN =

and contribute updates somewhere. Heh, I don't even know which MVNOs =

here are dead and which are operational.

--
Kind regards,
Tarmo
--===============5819791029082309188==--

