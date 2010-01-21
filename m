Content-Type: multipart/mixed; boundary="===============4733421484041511428=="
MIME-Version: 1.0
From: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [RFC] HFP support into oFono and BlueZ
Date: Thu, 21 Jan 2010 21:22:09 +0200
Message-ID: <20100121192209.GA30879@jh-x301>
In-Reply-To: <fbf08281001201158q23d13d9bj930a66271c527b43@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4733421484041511428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

Sorry about the delay in getting more comments from me. Here's the
result of an initial (and rather quick) review:

+static const char *connected2str(int i)
+{
+	switch (i) {
+		case GATEWAY_STATE_DISCONNECTED:
+			return "disconnected";
+		case GATEWAY_STATE_CONNECTING:
+			return "connecting";
+		case GATEWAY_STATE_CONNECTED:
+			return "connected";
+		case GATEWAY_STATE_PLAYING:
+			return "playing";
+		default:
+			return "";
+	}
+}

This should be called state2str and the state is gateway_state_t and not
int. Also name the variable more apropriately (e.g. "state").

+static void change_state(struct audio_device *dev, int new_state)

Same goes here. gateway_state_t and not int.

+	gw->sco =3D chan;
+	g_io_channel_ref(chan);

The convention is to do the variable assignment through the return value
of the _ref function. Please do that.

-	/* why is this here? */
 	fcntl(g_io_channel_unix_get_fd(chan), F_SETFL, 0);

Why are you removing this comment? Either remove the fcntl call
altogether, fix the comment to describe why the call is needed or then
don't do anything if you don't know what it's for.

+	if (!dbus_set_error_from_message(&derr, reply)) {
+		info("Agent reply: file descriptor passed successfuly");
+		return;
+	}

I don't think this is worth an info(). Use debug() instead.

+	g_idle_add(gateway_close, gw);

Do you really need to call gateway_close through an idle callback?
What's the problem with calling it directly?

+	/* make /dev/rfcomm serial port from chan */
+	memset(&req, 0, sizeof(req));
+	req.dev_id =3D -1;
+	req.flags =3D (1 << RFCOMM_REUSE_DLC);
+	bacpy(&req.src, &dev->src);
+	bacpy(&req.dst, &dev->dst);
+	req.channel =3D gw->channel;

What's this? I thought you removed all the RFCOMM TTY codde.

+	return;
 }

Unnecessary return at the end of a void function.

+	agent =3D g_new0(struct agent, 1);
+	if (!agent)
+		return g_dbus_create_error(msg,
+				ERROR_INTERFACE ".Failed",
+				"Failed to create a new agent");

g_new0() will either assert or always return non-NULL. Use g_try_new0
if you want to check for failure, but probably you can just remove the
check and keep using g_new0. Btw, src/agent.h already defines a struct
agent so it'd be better if you use another name, e.g. hf_agent.


+	agent->name =3D strdup(name);
+	agent->path =3D strdup(path);

Use g_strdup.

+	g_io_channel_ref(chan);
+	dev->gateway->rfcomm =3D chan;

Again, please do the assignment through the return value of _ref()

There are probably more issues, but these are the ones I found after an
initial glance-through. Please send an updated patch, preferably inline
(since as you notice I didn't manage to get my mailer to properly quote
this time) and I'll take a new look. Thanks.

Johan


--===============4733421484041511428==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0002-Implement-HandsfreeGateway-Interface.patch"

SGkgR3VzdGF2bywKClNvcnJ5IGFib3V0IHRoZSBkZWxheSBpbiBnZXR0aW5nIG1vcmUgY29tbWVu
dHMgZnJvbSBtZS4gSGVyZSdzIHRoZQpyZXN1bHQgb2YgYW4gaW5pdGlhbCAoYW5kIHJhdGhlciBx
dWljaykgcmV2aWV3OgoKK3N0YXRpYyBjb25zdCBjaGFyICpjb25uZWN0ZWQyc3RyKGludCBpKQor
eworCXN3aXRjaCAoaSkgeworCQljYXNlIEdBVEVXQVlfU1RBVEVfRElTQ09OTkVDVEVEOgorCQkJ
cmV0dXJuICJkaXNjb25uZWN0ZWQiOworCQljYXNlIEdBVEVXQVlfU1RBVEVfQ09OTkVDVElORzoK
KwkJCXJldHVybiAiY29ubmVjdGluZyI7CisJCWNhc2UgR0FURVdBWV9TVEFURV9DT05ORUNURUQ6
CisJCQlyZXR1cm4gImNvbm5lY3RlZCI7CisJCWNhc2UgR0FURVdBWV9TVEFURV9QTEFZSU5HOgor
CQkJcmV0dXJuICJwbGF5aW5nIjsKKwkJZGVmYXVsdDoKKwkJCXJldHVybiAiIjsKKwl9Cit9CgpU
aGlzIHNob3VsZCBiZSBjYWxsZWQgc3RhdGUyc3RyIGFuZCB0aGUgc3RhdGUgaXMgZ2F0ZXdheV9z
dGF0ZV90IGFuZCBub3QKaW50LiBBbHNvIG5hbWUgdGhlIHZhcmlhYmxlIG1vcmUgYXByb3ByaWF0
ZWx5IChlLmcuICJzdGF0ZSIpLgoKK3N0YXRpYyB2b2lkIGNoYW5nZV9zdGF0ZShzdHJ1Y3QgYXVk
aW9fZGV2aWNlICpkZXYsIGludCBuZXdfc3RhdGUpCgpTYW1lIGdvZXMgaGVyZS4gZ2F0ZXdheV9z
dGF0ZV90IGFuZCBub3QgaW50LgoKKwlndy0+c2NvID0gY2hhbjsKKwlnX2lvX2NoYW5uZWxfcmVm
KGNoYW4pOwoKVGhlIGNvbnZlbnRpb24gaXMgdG8gZG8gdGhlIHZhcmlhYmxlIGFzc2lnbm1lbnQg
dGhyb3VnaCB0aGUgcmV0dXJuIHZhbHVlCm9mIHRoZSBfcmVmIGZ1bmN0aW9uLiBQbGVhc2UgZG8g
dGhhdC4KCi0JLyogd2h5IGlzIHRoaXMgaGVyZT8gKi8KIAlmY250bChnX2lvX2NoYW5uZWxfdW5p
eF9nZXRfZmQoY2hhbiksIEZfU0VURkwsIDApOwoKV2h5IGFyZSB5b3UgcmVtb3ZpbmcgdGhpcyBj
b21tZW50PyBFaXRoZXIgcmVtb3ZlIHRoZSBmY250bCBjYWxsCmFsdG9nZXRoZXIsIGZpeCB0aGUg
Y29tbWVudCB0byBkZXNjcmliZSB3aHkgdGhlIGNhbGwgaXMgbmVlZGVkIG9yIHRoZW4KZG9uJ3Qg
ZG8gYW55dGhpbmcgaWYgeW91IGRvbid0IGtub3cgd2hhdCBpdCdzIGZvci4KCisJaWYgKCFkYnVz
X3NldF9lcnJvcl9mcm9tX21lc3NhZ2UoJmRlcnIsIHJlcGx5KSkgeworCQlpbmZvKCJBZ2VudCBy
ZXBseTogZmlsZSBkZXNjcmlwdG9yIHBhc3NlZCBzdWNjZXNzZnVseSIpOworCQlyZXR1cm47CisJ
fQoKSSBkb24ndCB0aGluayB0aGlzIGlzIHdvcnRoIGFuIGluZm8oKS4gVXNlIGRlYnVnKCkgaW5z
dGVhZC4KCisJZ19pZGxlX2FkZChnYXRld2F5X2Nsb3NlLCBndyk7CgpEbyB5b3UgcmVhbGx5IG5l
ZWQgdG8gY2FsbCBnYXRld2F5X2Nsb3NlIHRocm91Z2ggYW4gaWRsZSBjYWxsYmFjaz8KV2hhdCdz
IHRoZSBwcm9ibGVtIHdpdGggY2FsbGluZyBpdCBkaXJlY3RseT8KCisJLyogbWFrZSAvZGV2L3Jm
Y29tbSBzZXJpYWwgcG9ydCBmcm9tIGNoYW4gKi8KKwltZW1zZXQoJnJlcSwgMCwgc2l6ZW9mKHJl
cSkpOworCXJlcS5kZXZfaWQgPSAtMTsKKwlyZXEuZmxhZ3MgPSAoMSA8PCBSRkNPTU1fUkVVU0Vf
RExDKTsKKwliYWNweSgmcmVxLnNyYywgJmRldi0+c3JjKTsKKwliYWNweSgmcmVxLmRzdCwgJmRl
di0+ZHN0KTsKKwlyZXEuY2hhbm5lbCA9IGd3LT5jaGFubmVsOwoKV2hhdCdzIHRoaXM/IEkgdGhv
dWdodCB5b3UgcmVtb3ZlZCBhbGwgdGhlIFJGQ09NTSBUVFkgY29kZGUuCgorCXJldHVybjsKIH0K
ClVubmVjZXNzYXJ5IHJldHVybiBhdCB0aGUgZW5kIG9mIGEgdm9pZCBmdW5jdGlvbi4KCisJYWdl
bnQgPSBnX25ldzAoc3RydWN0IGFnZW50LCAxKTsKKwlpZiAoIWFnZW50KQorCQlyZXR1cm4gZ19k
YnVzX2NyZWF0ZV9lcnJvcihtc2csCisJCQkJRVJST1JfSU5URVJGQUNFICIuRmFpbGVkIiwKKwkJ
CQkiRmFpbGVkIHRvIGNyZWF0ZSBhIG5ldyBhZ2VudCIpOwoKZ19uZXcwKCkgd2lsbCBlaXRoZXIg
YXNzZXJ0IG9yIGFsd2F5cyByZXR1cm4gbm9uLU5VTEwuIFVzZSBnX3RyeV9uZXcwCmlmIHlvdSB3
YW50IHRvIGNoZWNrIGZvciBmYWlsdXJlLCBidXQgcHJvYmFibHkgeW91IGNhbiBqdXN0IHJlbW92
ZSB0aGUKY2hlY2sgYW5kIGtlZXAgdXNpbmcgZ19uZXcwLiBCdHcsIHNyYy9hZ2VudC5oIGFscmVh
ZHkgZGVmaW5lcyBhIHN0cnVjdAphZ2VudCBzbyBpdCdkIGJlIGJldHRlciBpZiB5b3UgdXNlIGFu
b3RoZXIgbmFtZSwgZS5nLiBoZl9hZ2VudC4KCgorCWFnZW50LT5uYW1lID0gc3RyZHVwKG5hbWUp
OworCWFnZW50LT5wYXRoID0gc3RyZHVwKHBhdGgpOwoKVXNlIGdfc3RyZHVwLgoKKwlnX2lvX2No
YW5uZWxfcmVmKGNoYW4pOworCWRldi0+Z2F0ZXdheS0+cmZjb21tID0gY2hhbjsKCkFnYWluLCBw
bGVhc2UgZG8gdGhlIGFzc2lnbm1lbnQgdGhyb3VnaCB0aGUgcmV0dXJuIHZhbHVlIG9mIF9yZWYo
KQoKVGhlcmUgYXJlIHByb2JhYmx5IG1vcmUgaXNzdWVzLCBidXQgdGhlc2UgYXJlIHRoZSBvbmVz
IEkgZm91bmQgYWZ0ZXIgYW4KaW5pdGlhbCBnbGFuY2UtdGhyb3VnaC4gUGxlYXNlIHNlbmQgYW4g
dXBkYXRlZCBwYXRjaCwgcHJlZmVyYWJseSBpbmxpbmUKKHNpbmNlIGFzIHlvdSBub3RpY2UgSSBk
aWRuJ3QgbWFuYWdlIHRvIGdldCBteSBtYWlsZXIgdG8gcHJvcGVybHkgcXVvdGUKdGhpcyB0aW1l
KSBhbmQgSSdsbCB0YWtlIGEgbmV3IGxvb2suIFRoYW5rcy4KCkpvaGFuCgo=

--===============4733421484041511428==--

