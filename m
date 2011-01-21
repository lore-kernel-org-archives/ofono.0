Content-Type: multipart/mixed; boundary="===============0909960099107626650=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: oFono exits on new voicecall with disconnected system bus
Date: Fri, 21 Jan 2011 13:10:51 +0100
Message-ID: <1295611851.3873.306.camel@aeonflux>
In-Reply-To: <AANLkTinuBhsEv3yduBfU6S58F-q9pddVVQrizn4KEKKA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0909960099107626650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicola,

> >> It seems that in src/voicecall.c/append_voicecall_properties "name"
> >> points to garbage as commenting the line:
> >> ofono_dbus_dict_append(dict, "Name", DBUS_TYPE_STRING, &name);
> >> fixes the problem.
> >
> > can you print the content of name and call->name fields as part of a
> > debug statement. I like to see what is in there.
> >
> > At least the pointer should be valid since it pointers to call->name
> > array. Maybe the content is just not UTF-8 string.
> =

> =

>         ofono_dbus_dict_append(dict, "LineIdentification",
>                                 DBUS_TYPE_STRING, &callerid);
> =

>         DBG("name %s call->name %s", name, call->name);
>         ofono_dbus_dict_append(dict, "Name", DBUS_TYPE_STRING, &name);
> =

> =

> ofonod[5771]: src/voicecall.c:ofono_voicecall_notify() Did not find a
> call with id: 1
> ofonod[5771]: src/voicecall.c:append_voicecall_properties() name =EF=BF=
=BD=EF=BF=BD+@
> call->name =EF=BF=BD=EF=BF=BD+@
> ofonod[5771]: System bus has disconnected!

I think that I found the problem. Pushed a patch for it. Please re-test
if this helps. The Calypso driver was using stack memory for the call
object.

Regards

Marcel



--===============0909960099107626650==--

