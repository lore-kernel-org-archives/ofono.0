Content-Type: multipart/mixed; boundary="===============6153702279358736380=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] drivers: constify vtables
Date: Wed, 17 Oct 2018 09:57:22 -0500
Message-ID: <9549f8a6-5239-5ac8-3b2f-b7ccf7d02c85@gmail.com>
In-Reply-To: <20181017133610.12217-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6153702279358736380==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 10/17/2018 08:36 AM, Jonas Bonn wrote:
> The driver vtables are read-only structures.  This patch declares them as
> 'const' allowing the compiler to (optionally) put them in the RELRO
> section.  RELRO pages may be marked as read-only by the linker after
> the relocations have been done ensuring that they aren't inadvertently
> or maliciously altered at runtime.
> ---
> =

> I've had this patch sitting around in my tree for a couple of months.
> Constification of the driver vtables is mostly for correctness and
> doesn't provide any noticeable difference in performance.
> =

> I have another couple of patches that take care of plugins/ and core
> ofono, but I thought I'd gauge the response on this first...
> =

> /Jonas

Looks fine to me.  Applied, thanks.

Regards,
-Denis


--===============6153702279358736380==--

