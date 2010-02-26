Content-Type: multipart/mixed; boundary="===============6277687632398116193=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] Do not trigger user disconnect at g_at_shutdown
Date: Fri, 26 Feb 2010 16:18:39 -0600
Message-ID: <201002261618.40200.denkenz@gmail.com>
In-Reply-To: <1267178192-21396-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6277687632398116193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> Similar to gatchat, introduce read_watcher_destroy_notify and do
> not trigger user disconnect at g_at_shutdown. Delay destroy of
> gatserver until read_watcher is destroyed.

Patch has been applied, thanks.

Regards,
-Denis

--===============6277687632398116193==--

