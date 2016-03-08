Content-Type: multipart/mixed; boundary="===============3373467032063670841=="
MIME-Version: 1.0
From: David Ashley <dashxdr@gmail.com>
Subject: Re: ofono with sim5320 module
Date: Tue, 08 Mar 2016 12:30:26 -0600
Message-ID: <CABkE59AjrNxZFeGdCzstM8UAka75EbptwjMR3pV5VtWsrjQ_RQ@mail.gmail.com>
In-Reply-To: <CABkE59DVsbx1igJvM1zTtu4t2Fken=RiDQQchLwyJhXG9BzT+w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3373467032063670841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Well this project seems to be dead. Anyway for what it's worth, the
problem turned out to be some difference between the AT+CMUX behavior
betwene the sim900 and the sim5320 module. When I tore out all the MUX
related code the 3G / internet / ppp aspects all just start working.

-Dave

On 3/7/16, David Ashley <dashxdr@gmail.com> wrote:
> Hello, I'm at my wits' end trying to get ofono working with the
> sim5320 module. I'm using the plugins/sim900.c module as a starting
> point. I think the issue has something to do with the difference
> between the MUX functionality between the 900 and the 5320.

--===============3373467032063670841==--

