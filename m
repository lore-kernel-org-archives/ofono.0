Content-Type: multipart/mixed; boundary="===============3513330589839708006=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [isi-voicecall-fix PATCHv3 4/6] isi/voicecall: fix answering
 early incoming calls
Date: Mon, 22 Nov 2010 10:38:36 -0600
Message-ID: <4CEA9C8C.20901@gmail.com>
In-Reply-To: <AANLkTimx7NnptbUQH=RQLXwuAV74wtyECDm5zE4NXdAs@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3513330589839708006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 11/22/2010 10:22 AM, Pekka Pessi wrote:
> Hi Denis,
> =

> 2010/11/22 Denis Kenzior <denkenz@gmail.com>:
>>> +static void isi_wait_incoming(struct isi_call_req_context *irc, int ev=
ent);
>>> +
>>
>> Why is there a forward declaration for a static function?
> =

> Because there is a dependency loop: isi_call_answer_req uses
> isi_wait_incoming and isi_wait_incoming calls isi_call_answer_req.
> =


Ok, fair enough.

Regards,
-Denis

--===============3513330589839708006==--

