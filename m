Content-Type: multipart/mixed; boundary="===============6640889148838389410=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH] Checking PIN length based on its type (PIN / PUK / NET).
Date: Fri, 19 Mar 2010 17:01:46 +0200
Message-ID: <80fd4e751003190801h1369413by1ecffe1f3db05bd5@mail.gmail.com>
In-Reply-To: <1269009312-16345-1-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6640889148838389410==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/3/19  <ppessi@gmail.com>:
> - =C2=A0 =C2=A0 =C2=A0 if (!strcmp(new, old))
> + =C2=A0 =C2=A0 =C2=A0 if (!strcmp(new, old, PIN_TYPE_PIN))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return dbus_messag=
e_new_method_return(msg);

I could have sworn I compiled and run the code, but then probably not.

-- =

Pekka.Pessi mail at nokia.com

--===============6640889148838389410==--

