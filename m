Content-Type: multipart/mixed; boundary="===============7986823870110089130=="
MIME-Version: 1.0
From: Nicola Mfb <nicola.mfb@gmail.com>
Subject: Re: oFono exits on new voicecall with disconnected system bus
Date: Fri, 21 Jan 2011 10:04:54 +0100
Message-ID: <AANLkTinOHgArHXeEtVgq23X+XYF0daQ=u62SnMtbMOYO@mail.gmail.com>
In-Reply-To: <1295535351.3873.294.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7986823870110089130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 20, 2011 at 3:55 PM, Marcel Holtmann <marcel@holtmann.org> wr=
ote:

> Hi Nicola,

Hi Marcel,

[...]

>> ofonod[6232]: src/voicecall.c:ofono_voicecall_notify() Did not find a
>> call with id: 1
>> ofonod[6232]: System bus has disconnected!
>
> this happens if something in a D-Bus message is corrupted and the D-Bus
> daemon complains. The result is that it kicks us off the bus.
>
> You need to track down which D-Bus API call causes this. Wild assumption
> is that it is either a wrong message parameter or an invalid object
> path.

It seems that in src/voicecall.c/append_voicecall_properties "name"
points to garbage as commenting the line:
ofono_dbus_dict_append(dict, "Name", DBUS_TYPE_STRING, &name);
fixes the problem.

Regards

     Niko

--===============7986823870110089130==--

