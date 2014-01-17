Content-Type: multipart/mixed; boundary="===============0335650773356874400=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gprs: Use "internet" apn for auto-created context
Date: Thu, 16 Jan 2014 21:43:39 -0600
Message-ID: <52D8A6EB.90506@gmail.com>
In-Reply-To: <52D84681.6000706@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0335650773356874400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

A gentle reminder to please not top-post on this mailing list.

On 01/16/2014 02:52 PM, Slava Monich wrote:
> Hi Denis,
>
> Sorry to bother you, but I don't quite get the logic. There's something
> that needs to be done in case if ALL provisioning plugins have run and
> failed. How could that be a part of a provisioning plugin? They all have
> already run and failed by definition of the problem.

We do; we create an empty context to signify that provisioning has =

failed.  I do realize you mean well, but you're trying to wildly guess =

(at least that is how I read the commit description) and breaking =

existing behavior.

>
> And another thing. If context initialization belongs exclusively to the
> provisioning plugins then what is this add_context() call doing there?
> And why INTERNET context is created but, say, MMS is not? Isn't that a
> wild guess too? If so then I have found exactly the right place for
> another wild guess. Or am I missing something?

You are :)  The special context is not meant to be used, and is by =

design meant to always fail.

An empty APN is by definition invalid, so it is used as a 'special' flag =

value.  The 'special' empty APN context is used by various oFono UIs to =

start a user-guided provisioning process.  If you mess with this =

behavior, you will break those UIs.

Why only an internet context is created is largely historical.  This =

behavior probably predates MMS contexts.

>
> I don't want to waste your time as well as mine by submitting patches
> that get rejected but in order to do so I have to understand why patches
> get rejected.

Completely understandable.  Please feel free to start a conversation on =

the mailing list or the IRC channel whenever you feel you need more =

information.

Regards,
-Denis

--===============0335650773356874400==--

