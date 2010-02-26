Content-Type: multipart/mixed; boundary="===============0108098979776607291=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] Add write buffer queue for non-blocking write
Date: Fri, 26 Feb 2010 16:19:33 -0600
Message-ID: <201002261619.33696.denkenz@gmail.com>
In-Reply-To: <1267178192-21396-3-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0108098979776607291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> The head of the queue is the data to be written, the tail is the
> free buffer to cache data into.
> =

> If the tail of queue is full, allocate a new free buffer and
> append it at the tail.

Patch has been applied with one minor tweak afterwards.

Thanks,
-Denis

--===============0108098979776607291==--

