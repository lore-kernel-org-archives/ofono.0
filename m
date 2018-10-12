Content-Type: multipart/mixed; boundary="===============0125716080877168075=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH v3 1/1] atmodem/lte: proto and authentication handling
Date: Fri, 12 Oct 2018 12:59:22 -0500
Message-ID: <e8c01c63-cac6-4b3b-865f-6e90c65d2682@gmail.com>
In-Reply-To: <CAKSBH7EWLpeujk-QegZmB0P3P7Kdi4Tv1PLg7F0gb6T0WPLZMg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0125716080877168075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 10/12/2018 11:54 AM, Giacinto Cifelli wrote:
> Hi,
> =

> I trust you, but I have checked the code :)
> =

> you are right, the at_command_create may fail (on allocation error
> from g_try_new0) and in this case it doesn't call the g_free.
> =

> However I have to say that the code leaks alot: overall the construct
> is used 237 times, and only 98 times the g_free is called.

Umm, can you give me some examples?  Do note that we have 2 patterns =

that we use:

Pattern 1 is the most common:

if (g_at_chat_send(...) > 0)
	return;

g_free/destroy(...);
CALLBACK_WITH_FAILURE();

Pattern 2 is what you want:

if (g_at_chat_send(...) =3D=3D 0) {
	g_free/destroy(...);
	CALLBACK_WITH_FAILURE();
	return;
}

> That said, according to Denis nowadays we don't use g_try_new0 because
> the allocation won't fail, so we are unlikely to see it in action.
That is not really an excuse, and we can change the implementation of =

send() at any time.  So you still need to be paranoid.

Regards,
-Denis

--===============0125716080877168075==--

