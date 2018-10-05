Content-Type: multipart/mixed; boundary="===============9187980849517325711=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/6] drivers: support for auth NONE
Date: Thu, 04 Oct 2018 22:23:00 -0500
Message-ID: <5868f423-1fd0-febf-c3fc-6940ecab60f6@gmail.com>
In-Reply-To: <CAKSBH7HHoEnjTMvqyG6KqRKuTOZN+pbCvj7CBm5510uBG47ktg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9187980849517325711==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> You are not giving any choice here, other than rewriting gcc.
> The function I have tried, and the compiler still complains.
> I need a way out: please decide for the lesser evil, and I'll do it.
> =


I already gave you two way out actually.  So tell me why either of the =

below wouldn't work:

So for example, the way gprs-context.c for mbim does this is just fine.

switch (method) {
case CHAP:
	return ..
case PAP:
	return ..
}

return something, anything;

Since the core guarantees that method will always be a valid =

enumeration, the above approach is just fine and satisfies both items M7 =

and M12.

If you want to be more paranoid, then:

int auth_method_to_foo(enum ofono_gprs_auth_method method, uint32_t *out)
{
	switch (method) {
	case PAP:
		*out =3D ..
		return 0;
	case CHAP:
		*out =3D ..
		return 0;
	}

	return -ERANGE;
}

uint32_t auth;

if (auth_method_to_foo(method, &auth) < 0)
	goto error;

Regards,
-Denis

--===============9187980849517325711==--

