Content-Type: multipart/mixed; boundary="===============0578065207506838619=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH v3 1/1] atmodem/lte: proto and authentication handling
Date: Fri, 12 Oct 2018 13:53:45 -0500
Message-ID: <dbf1fa8d-fd15-0890-ebfe-e0b8e4ad82c8@gmail.com>
In-Reply-To: <CAKSBH7HNpY9Zn98SKC+m83z-Bq_i5NM5D+TXj-L7odyJZ5UPcg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0578065207506838619==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

>>> +     cbd->cb =3D cb;
>>> +     cbd->data =3D data;
>>> +     cbd->ldd =3D ldd;
>>
>> You can't really do that.  There's no guarantee that the core atom will
>> keep this object around for the lifetime of the driver transaction.
> =

> That's interesting. Can I pass const struct ofono_lte *lte, or the
> same constraints apply?
> Or some other object that I can rely upon?
> Also, the core atom shouldn't be called until the callback is triggered.

Why would you need to?  In general one can assume that the atom is =

around until the .remove method is called.  But you cannot assume that =

anything passed into the driver will live past the point that the driver =

function returns.

> =

>> Why do you need this anyway?  Is it just to build the +CGAUTH part?  Why
>> don't you l_strdup_printf the +CGAUTH commmand or something instead and
>> invoke it in the callback?
>>
>> E.g. cbd =3D cb_data_new();
>> char *cgauth_cmd =3D g_strdup_printf("CGAUTH=3D0,1,"%s","%s", username,
>> password);
> =

> I will check this, also for compatibility with the switch(vendor) to
> come, but I have to confess
> I don't really like building the command somewhere and using it later.
> It is unexpected for someone reading the code.
> What if I have to chain more commands?
> =


Then memcpy the pending structure (or the needed members) into an area =

with lifetime you control.

>>
>> Why are you removing the destructor.  This will cause leaks whenever a
>> hot-unplug event happens and this command is queued...
>>
>> If you want to use cbd across multiple commands, the proper way to do
>> that is with a reference counted structure.
> =

> is there an example elsewhere in the code?
> =


drivers/ubloxmodem/netmon.c
drivers/hfpmodem/slc.c

There may be a few other places that get this wrong and should be fixed. =

  Feel free to point them out when/if you see these.

Regards,
-Denis

--===============0578065207506838619==--

