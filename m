Content-Type: multipart/mixed; boundary="===============9086832065457162424=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] Fix server only return the final parser result
Date: Wed, 03 Mar 2010 13:09:44 -0600
Message-ID: <201003031309.44884.denkenz@gmail.com>
In-Reply-To: <1267525299-5740-4-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9086832065457162424==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> In case we meet compound commands in single line, AtServer should
> only return the parser result of last command according to spec.
> So we return the parser result in the parse iteration.

So I agree that we need to do this, but I disagree with the approach.  I =

suggest we let g_at_server_send_result take care of this.  This will make =

extended errors much easier to handle.

Regards,
-Denis

--===============9086832065457162424==--

