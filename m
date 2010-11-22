Content-Type: multipart/mixed; boundary="===============2605675297946624738=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [isi-voicecall-fix PATCHv3 4/6] isi/voicecall: fix answering
 early incoming calls
Date: Mon, 22 Nov 2010 18:22:42 +0200
Message-ID: <AANLkTimx7NnptbUQH=RQLXwuAV74wtyECDm5zE4NXdAs@mail.gmail.com>
In-Reply-To: <4CEA7BDE.9060405@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2605675297946624738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2010/11/22 Denis Kenzior <denkenz@gmail.com>:
>> +static void isi_wait_incoming(struct isi_call_req_context *irc, int eve=
nt);
>> +
>
> Why is there a forward declaration for a static function?

Because there is a dependency loop: isi_call_answer_req uses
isi_wait_incoming and isi_wait_incoming calls isi_call_answer_req.

-- =

Pekka.Pessi mail at nokia.com

--===============2605675297946624738==--

