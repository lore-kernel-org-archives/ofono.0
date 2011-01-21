Content-Type: multipart/mixed; boundary="===============3435246471478132831=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: oFono exits on new voicecall with disconnected system bus
Date: Fri, 21 Jan 2011 11:29:03 +0100
Message-ID: <1295605743.3873.304.camel@aeonflux>
In-Reply-To: <AANLkTinOHgArHXeEtVgq23X+XYF0daQ=u62SnMtbMOYO@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3435246471478132831==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicola,

> >> ofonod[6232]: src/voicecall.c:ofono_voicecall_notify() Did not find a
> >> call with id: 1
> >> ofonod[6232]: System bus has disconnected!
> >
> > this happens if something in a D-Bus message is corrupted and the D-Bus
> > daemon complains. The result is that it kicks us off the bus.
> >
> > You need to track down which D-Bus API call causes this. Wild assumption
> > is that it is either a wrong message parameter or an invalid object
> > path.
> =

> It seems that in src/voicecall.c/append_voicecall_properties "name"
> points to garbage as commenting the line:
> ofono_dbus_dict_append(dict, "Name", DBUS_TYPE_STRING, &name);
> fixes the problem.

can you print the content of name and call->name fields as part of a
debug statement. I like to see what is in there.

At least the pointer should be valid since it pointers to call->name
array. Maybe the content is just not UTF-8 string.

Regards

Marcel



--===============3435246471478132831==--

