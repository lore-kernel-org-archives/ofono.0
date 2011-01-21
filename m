Content-Type: multipart/mixed; boundary="===============1484539748517084235=="
MIME-Version: 1.0
From: Nicola Mfb <nicola.mfb@gmail.com>
Subject: Re: oFono exits on new voicecall with disconnected system bus
Date: Fri, 21 Jan 2011 12:33:43 +0100
Message-ID: <AANLkTinuBhsEv3yduBfU6S58F-q9pddVVQrizn4KEKKA@mail.gmail.com>
In-Reply-To: <1295605743.3873.304.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1484539748517084235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 21, 2011 at 11:29 AM, Marcel Holtmann <marcel@holtmann.org> w=
rote:

[...]

>> It seems that in src/voicecall.c/append_voicecall_properties "name"
>> points to garbage as commenting the line:
>> ofono_dbus_dict_append(dict, "Name", DBUS_TYPE_STRING, &name);
>> fixes the problem.
>
> can you print the content of name and call->name fields as part of a
> debug statement. I like to see what is in there.
>
> At least the pointer should be valid since it pointers to call->name
> array. Maybe the content is just not UTF-8 string.


        ofono_dbus_dict_append(dict, "LineIdentification",
                                DBUS_TYPE_STRING, &callerid);

        DBG("name %s call->name %s", name, call->name);
        ofono_dbus_dict_append(dict, "Name", DBUS_TYPE_STRING, &name);


ofonod[5771]: src/voicecall.c:ofono_voicecall_notify() Did not find a
call with id: 1
ofonod[5771]: src/voicecall.c:append_voicecall_properties() name =EF=BF=BD=
=EF=BF=BD+@
call->name =EF=BF=BD=EF=BF=BD+@
ofonod[5771]: System bus has disconnected!

     Niko

--===============1484539748517084235==--

