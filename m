Content-Type: multipart/mixed; boundary="===============0970249090364487402=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [RFC PATCH 12/30] qmi: replace GQueues for requests
Date: Wed, 28 Mar 2018 23:06:43 +0200
Message-ID: <2f50686d-9be8-726c-987c-abe9c1ce1e44@southpole.se>
In-Reply-To: <c11dd97f-ffe9-e57c-0ba9-ba1c5e1f1b5d@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0970249090364487402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 28/03/18 22:16, Denis Kenzior wrote:
> Hi Jonas,
>
> On 03/28/2018 01:59 PM, Jonas Bonn wrote:
>> This brings in list.h from the Linux kernel and replaces the GQueues
>> used for enqueuing requests with struct list_heads.=C2=A0 These list
>> operations are both more efficient and generally easier to work with.
>
> In general I agree, but do they really have any significant advantages =

> for our use cases?=C2=A0 Its not like we maintain items on multiple lists=
...

By the end of the series we have requests on both the device list and on =

the service list.

The biggest advantage is when removing items from the lists that they =

are on.=C2=A0 Since the object on the list knows how it is attached to the =

list (via its list head), it can detach itself from the list without =

need access to the "list object" itself.=C2=A0 With glib lists, a request o=
n =

both a device and service list would need to be able to access the =

device in order to get the device's list in order to be able to ask the =

list to delete it and then do the same for the service.=C2=A0 With the Linu=
x =

lists you just do "detach me" (list_del(node)) and you're done... much =

better code

Aside from that, the Linux lists are really simple macros, not function =

calls; all the state they require is in the list items itself, no extra =

list entry holders required; they are cache friendly; etc.=C2=A0 Lots of =

advantages, though these are mostly moot in ofono where list performance =

isn't really an issue.

Anyway, please bear with these lists for this cleanup.=C2=A0 When the share=
d =

service cleanup is done, we can return to GQueues if necessary and then =

we'll have a clearer picture of what the difference is.=C2=A0 As things sta=
nd =

though, things are complicated enough that the GQueues are just in the way.

Trying to find a series of small patches through this cleanup hasn't =

been easy.=C2=A0 The first attempts I did ended up ballooning because when =

you start trying to make the change in patch 29 you pretty much =

automatically end up with most of the other changes in the preceding 28 =

patches before this system is operational again... so the alternative to =

some of these (possibly) oddball patches was one _big_ patch that wasn't =

reviewable.

/Jonas

>
>> Since ofono and Linux share a common license, this code borrowing should
>> not be problematic in any way.
>
> While there's no problem with the license, I really don't want QMI to =

> look completely alien to the rest of the code base.=C2=A0 We use GLib sty=
le =

> lists everywhere, so I'm really hesitant to go this way.=C2=A0 I think I'=
d =

> rather we stuck to that (or switch to ell) for code maintenance & =

> readability reasons.
>
> Regards,
> -Denis


--===============0970249090364487402==--

