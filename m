Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7D2219F9
	for <ofono@lists.linux.dev>; Sun, 21 Apr 2024 20:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713730025; cv=none; b=J3UlPjA2palQKgaXYhonGLMAJ7c1Itvwmn/lwSr5cyNj7LxWogKq9F5z1a8hCfVm3ynSdm/fvFvbzyFrR8c9pR6oE5+zVPpOLntpvrZOp+guRKQpyqKon5xKRr4Cow8Mm6wh4vmBC8dFTKwcBuuYzt32unbZhfwWFX5yGgQ0WeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713730025; c=relaxed/simple;
	bh=frB/KNa3XN/hVhkn2eVDSNnW8C5yfh6t9e/H3U9lGuo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GAJ1dw+Ukm4moA4v+9SMF2oVvCOEIdq89wxIAZA/x2FmG5NhjDIc6jisZReZfSNcFQPpf1WE6tl8KXD5dYUTA3BwRPxtodJaS0Mcip2MS/Th1F/jmWXggfYab31tc/23y9CyL23hDqAZ79D49Wcopkl5kuXx4Oos+BDGhxGwcdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvz8xlC6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvz8xlC6"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4155819f710so30839545e9.2
        for <ofono@lists.linux.dev>; Sun, 21 Apr 2024 13:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713730021; x=1714334821; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PNVdFrPcJdmJDCZWwUiRp7Gc83MAiv2IX/Q7dCvCvVc=;
        b=gvz8xlC6XOyGCu2HG/35I68IMbbJ4SoO1kkiBylMZ2feG4TFDFg1GW50+Rjtv4FuYy
         VTu3Y4WrhjAdfk7tU3ni06aKmTLXcMEaRkmmtCazU+ASF7xyffZiBQ5a/NLCRDxxhEpu
         I0hdEJttmrLFNDf9KElGZX8QH6eGKkOHgBzXmrcK1YX64yzOnJ9AgCeTfmMtl9iF6JVg
         24N76ti/2rPTWVxRLD3+5DJOmokaDEcJFppsma8PUCiD5RA3wRRBGM9GRl8InRuB1fZ8
         ldcitlUcN9UMpdNOF8dC1OIS7apJXnN+YuO4iCJOk2OXFa66Dyb9JI5ngVI2VNAPM0SE
         F5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713730021; x=1714334821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNVdFrPcJdmJDCZWwUiRp7Gc83MAiv2IX/Q7dCvCvVc=;
        b=MRDDL0CkSM0MbUoIjcdtwtmmL+CWJoQnA+8tuAnR9c0P5FMVfKb5htF1RtJSpchTAR
         GvVOms2GWXJBf5HVQg+6+RGsGTJ3TtJSrWPKeT2KPiZXHK9QcRhkgmJ7IgG5XDAK5xYo
         Zcn7L8xMU/ZUcvRNp8/sp8wWUtomcDg5eszW8xs1Uf0HLyEUxE7nvRD8k6AyVpE/zP9m
         bH6t+ngJXwe0H6l6K0mEhA93vz5wHrfIt8GmNc8hb5WAIsrDTsak/EefvMQNnTnkYfb/
         C8FMyrdxRIa0czerqDXcgIWQ6Fqo+klzalo2XyoB7l2SDzvX/zM5Sqhx8Cc09N5eDuJE
         fp7w==
X-Gm-Message-State: AOJu0YzUgtTgsTbTktTwSN/Ry1VkH9yDy8JjrKeQUL9xFpRvs6B19Uj/
	N0ek/HsAt4sHRJvoULJBMjFwmLqzJTo+ajwTwPdjgxWeGr5EW/MpAy7jfg==
X-Google-Smtp-Source: AGHT+IFq3R0Er5Nw/rdVptxx4Axz2pWR4hLNZyXD9pT05fP4mMTIDE2vx/lpz/6WBaapdcee8O5JCw==
X-Received: by 2002:a05:600c:5249:b0:418:9f2c:5240 with SMTP id fc9-20020a05600c524900b004189f2c5240mr6543547wmb.33.1713730021361;
        Sun, 21 Apr 2024 13:07:01 -0700 (PDT)
Received: from adam-laptop-hp.localnet ([84.69.230.138])
        by smtp.gmail.com with ESMTPSA id fl16-20020a05600c0b9000b0041a59d677b6sm1012300wmb.16.2024.04.21.13.07.00
        for <ofono@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 13:07:00 -0700 (PDT)
From: Adam Pigg <piggz1@gmail.com>
To: ofono@lists.linux.dev
Subject: Re: [PATCH 1/4] qmimodem: voicecall: Implement call dialing
Date: Sun, 21 Apr 2024 21:06:59 +0100
Message-ID: <2502918.XAFRqVoOGU@adam-laptop-hp>
In-Reply-To: <20240421194926.13149-1-adam@piggz.co.uk>
References: <20240421194926.13149-1-adam@piggz.co.uk>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Apologies, i missed the -v5 flag

On Sunday 21 April 2024 20:49:03 BST you wrote:
> Add voicecall dialling to the qmimodem driver
> Includes required infrastructure and setup of the QMI services
> 
> Call State Handling
> ===================
> On initialisation, register the all_call_status_ind callback to be
> called for QMI_VOICE_IND_ALL_STATUS.  This will handle notification of
> call status to the rest of the system
> 
> Dial Handling
> =============
> The dial function sets up the parameters for the QMI_VOICE_DIAL_CALL
> service.  The parameters are the number to be called and the call type,
> which is currently hard coded to be QMI_VOICE_CALL_TYPE_VOICE.  The
> dial_cb callback will then be called and will receive the call-id.
> 
> ---
> Changes in V4
> -merged qmi_voice_call_status and all_call_status_ind
> -several minor structure/formate changes
> 
> Changes in V5
> -renames ofono_call_compare_by_id to ofono_call_match_by_id
> -updated new_entry pointer to fix use-after-free in
> ofono_call_list_notify
> -Renamed several constants
> -in all_call_status_ind removed error label/gotos after restructuring
> -When creating the call list, ensure an upper bound of 16
> -Fix out-of-mound-read on remote number due to QMI string not being null
> terminated
> ---
> ---
>  drivers/qmimodem/voice.h     |  17 ++
>  drivers/qmimodem/voicecall.c | 426 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 442 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/qmimodem/voice.h b/drivers/qmimodem/voice.h
> index 917e72f7..2344fd50 100644
> --- a/drivers/qmimodem/voice.h
> +++ b/drivers/qmimodem/voice.h
> @@ -48,6 +48,9 @@ enum qmi_ussd_user_required {
> 
>  /* QMI service voice. Using an enum to prevent doublicated entries */
>  enum voice_commands {
> +	QMI_VOICE_DIAL_CALL =			0x20,
> +	QMI_VOICE_ALL_CALL_STATUS_IND =		0x2e,
> +	QMI_VOICE_GET_ALL_CALL_INFO =		0x2f,
>  	QMI_VOICE_SUPS_NOTIFICATION_IND =	0x32,
>  	QMI_VOICE_SET_SUPS_SERVICE =		0x33,
>  	QMI_VOICE_GET_CALL_WAITING =		0x34,
> @@ -66,6 +69,20 @@ enum voice_commands {
>  	QMI_VOICE_GET_CNAP =			0x4d
>  };
> 
> +enum qmi_voice_call_state {
> +	QMI_VOICE_CALL_STATE_IDLE = 0x0,
> +	QMI_VOICE_CALL_STATE_ORIG,
> +	QMI_VOICE_CALL_STATE_INCOMING,
> +	QMI_VOICE_CALL_STATE_CONV,
> +	QMI_VOICE_CALL_STATE_CC_IN_PROG,
> +	QMI_VOICE_CALL_STATE_ALERTING,
> +	QMI_VOICE_CALL_STATE_HOLD,
> +	QMI_VOICE_CALL_STATE_WAITING,
> +	QMI_VOICE_CALL_STATE_DISCONNECTING,
> +	QMI_VOICE_CALL_STATE_END,
> +	QMI_VOICE_CALL_STATE_SETUP
> +};
> +
>  struct qmi_ussd_data {
>  	uint8_t dcs;
>  	uint8_t length;
> diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
> index aa34fc25..7b4813c9 100644
> --- a/drivers/qmimodem/voicecall.c
> +++ b/drivers/qmimodem/voicecall.c
> @@ -3,6 +3,7 @@
>   *  oFono - Open Source Telephony
>   *
>   *  Copyright (C) 2011-2012  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2024 Adam Pigg <adam@piggz.co.uk>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2 as
> @@ -26,6 +27,10 @@
>  #include <ofono/log.h>
>  #include <ofono/modem.h>
>  #include <ofono/voicecall.h>
> +#include <src/common.h>
> +#include <ell/ell.h>
> +
> +#include "voice.h"
> 
>  #include "qmi.h"
> 
> @@ -35,8 +40,422 @@ struct voicecall_data {
>  	struct qmi_service *voice;
>  	uint16_t major;
>  	uint16_t minor;
> +	struct l_queue *call_list;
> +	struct ofono_phone_number dialed;
>  };
> 
> +struct qmi_voice_call_information_instance {
> +	uint8_t id;
> +	uint8_t state;
> +	uint8_t type;
> +	uint8_t direction;
> +	uint8_t mode;
> +	uint8_t multipart_indicator;
> +	uint8_t als;
> +} __attribute__((__packed__));
> +
> +struct qmi_voice_call_information {
> +	uint8_t size;
> +	struct qmi_voice_call_information_instance instance[0];
> +} __attribute__((__packed__));
> +
> +struct qmi_voice_remote_party_number_instance {
> +	uint8_t call_id;
> +	uint8_t presentation_indicator;
> +	uint8_t number_size;
> +	char number[0];
> +} __attribute__((__packed__));
> +
> +struct qmi_voice_remote_party_number {
> +	uint8_t size;
> +	struct qmi_voice_remote_party_number_instance instance[0];
> +} __attribute__((__packed__));
> +
> +static int ofono_call_compare(const void *a, const void *b, void *data)
> +{
> +	const struct ofono_call *ca = a;
> +	const struct ofono_call *cb = b;
> +
> +	if (ca->id < cb->id)
> +		return -1;
> +
> +	if (ca->id > cb->id)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static bool ofono_call_match_by_id(const void *a, const void *b)
> +{
> +	const struct ofono_call *call = a;
> +	unsigned int id = L_PTR_TO_UINT(b);
> +
> +	return (call->id == id);
> +}
> +
> +static void ofono_call_list_dial_callback(struct ofono_voicecall *vc,
> +						int call_id)
> +{
> +	struct ofono_call *call;
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct l_queue *call_list = vd->call_list;
> +	const struct ofono_phone_number *ph = &vd->dialed;
> +
> +	/* check if call_id already present */
> +	call = l_queue_find(call_list, ofono_call_match_by_id,
> +				L_UINT_TO_PTR(call_id));
> +
> +	if (call)
> +		return;
> +
> +	call = l_new(struct ofono_call, 1);
> +	call->id = call_id;
> +
> +	memcpy(&call->called_number, ph, sizeof(*ph));
> +	call->direction = CALL_DIRECTION_MOBILE_ORIGINATED;
> +	call->status = CALL_STATUS_DIALING;
> +	call->type = 0; /* voice */
> +
> +	l_queue_insert(call_list, call, ofono_call_compare, NULL);
> +
> +	ofono_voicecall_notify(vc, call);
> +}
> +
> +static void ofono_call_list_notify(struct ofono_voicecall *vc,
> +					struct l_queue *calls)
> +{
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct l_queue *old_calls = vd->call_list;
> +	struct l_queue *new_calls = calls;
> +	struct ofono_call *new_call, *old_call;
> +	const struct l_queue_entry *old_entry, *new_entry;
> +	uint i;
> +
> +	uint loop_length =
> +		MAX(l_queue_length(old_calls), 
l_queue_length(new_calls));
> +
> +	old_entry = l_queue_get_entries(old_calls);
> +	new_entry = l_queue_get_entries(new_calls);
> +
> +	for (i = 0; i < loop_length; ++i) {
> +		old_call = old_entry ? old_entry->data : NULL;
> +		new_call = new_entry ? new_entry->data : NULL;
> +
> +		if (new_call && new_call->status == 
CALL_STATUS_DISCONNECTED) {
> +			ofono_voicecall_disconnected(
> +				vc, new_call->id,
> +				
OFONO_DISCONNECT_REASON_REMOTE_HANGUP, NULL);
> +			new_entry = new_entry->next;
> +			l_queue_remove(calls, new_call);
> +			l_free(new_call);
> +			continue;
> +		}
> +
> +		if (old_call &&
> +				(!new_call || (new_call->id > 
old_call->id)))
> +			ofono_voicecall_disconnected(
> +				vc, old_call->id,
> +				
OFONO_DISCONNECT_REASON_REMOTE_HANGUP, NULL);
> +		else if (new_call &&
> +				(!old_call || (new_call->id < 
old_call->id))) {
> +			DBG("Notify new call %d", new_call->id);
> +			/* new call, signal it */
> +			if (new_call->type == 0)
> +				ofono_voicecall_notify(vc, 
new_call);
> +		} else if (memcmp(new_call, old_call, sizeof(*new_call)) 
&&
> +				new_call->type == 0)
> +			ofono_voicecall_notify(vc, new_call);
> +
> +		if (old_entry)
> +			old_entry = old_entry->next;
> +		if (new_entry)
> +			new_entry = new_entry->next;
> +	}
> +
> +	l_queue_destroy(old_calls, l_free);
> +	vd->call_list = calls;
> +}
> +
> +static const char *qmi_voice_call_state_name(enum qmi_voice_call_state
> value) +{
> +	switch (value) {
> +	case QMI_VOICE_CALL_STATE_IDLE:
> +		return "QMI_VOICE_CALL_STATE_IDLE";
> +	case QMI_VOICE_CALL_STATE_ORIG:
> +		return "QMI_VOICE_CALL_STATE_ORIG";
> +	case QMI_VOICE_CALL_STATE_INCOMING:
> +		return "QMI_VOICE_CALL_STATE_INCOMING";
> +	case QMI_VOICE_CALL_STATE_CONV:
> +		return "QMI_VOICE_CALL_STATE_CONV";
> +	case QMI_VOICE_CALL_STATE_CC_IN_PROG:
> +		return "QMI_VOICE_CALL_STATE_CC_IN_PROG";
> +	case QMI_VOICE_CALL_STATE_ALERTING:
> +		return "QMI_VOICE_CALL_STATE_ALERTING";
> +	case QMI_VOICE_CALL_STATE_HOLD:
> +		return "QMI_VOICE_CALL_STATE_HOLD";
> +	case QMI_VOICE_CALL_STATE_WAITING:
> +		return "QMI_VOICE_CALL_STATE_WAITING";
> +	case QMI_VOICE_CALL_STATE_DISCONNECTING:
> +		return "QMI_VOICE_CALL_STATE_DISCONNECTING";
> +	case QMI_VOICE_CALL_STATE_END:
> +		return "QMI_VOICE_CALL_STATE_END";
> +	case QMI_VOICE_CALL_STATE_SETUP:
> +		return "QMI_VOICE_CALL_STATE_SETUP";
> +	}
> +	return "QMI_CALL_STATE_<UNKNOWN>";
> +}
> +
> +static bool qmi_to_ofono_status(uint8_t status, int *ret)
> +{
> +	int err = false;
> +
> +	switch (status) {
> +	case QMI_VOICE_CALL_STATE_IDLE:
> +	case QMI_VOICE_CALL_STATE_END:
> +	case QMI_VOICE_CALL_STATE_DISCONNECTING:
> +		*ret = CALL_STATUS_DISCONNECTED;
> +		break;
> +	case QMI_VOICE_CALL_STATE_HOLD:
> +		*ret = CALL_STATUS_HELD;
> +		break;
> +	case QMI_VOICE_CALL_STATE_WAITING:
> +		*ret = CALL_STATUS_WAITING;
> +		break;
> +	case QMI_VOICE_CALL_STATE_ORIG:
> +		*ret = CALL_STATUS_DIALING;
> +		break;
> +	case QMI_VOICE_CALL_STATE_SETUP:
> +	case QMI_VOICE_CALL_STATE_INCOMING:
> +		*ret = CALL_STATUS_INCOMING;
> +		break;
> +	case QMI_VOICE_CALL_STATE_CONV:
> +		*ret = CALL_STATUS_ACTIVE;
> +		break;
> +	case QMI_VOICE_CALL_STATE_CC_IN_PROG:
> +		*ret = CALL_STATUS_DIALING;
> +		break;
> +	case QMI_VOICE_CALL_STATE_ALERTING:
> +		*ret = CALL_STATUS_ALERTING;
> +		break;
> +	default:
> +		err = true;
> +	}
> +	return err;
> +}
> +
> +static enum call_direction qmi_to_ofono_direction(uint8_t qmi_direction)
> +{
> +	return qmi_direction - 1;
> +}
> +
> +static void all_call_status_ind(struct qmi_result *result, void *user_data)
> +{
> +	struct ofono_voicecall *vc = user_data;
> +
> +	int i;
> +	int offset;
> +	uint16_t len;
> +	bool status = true;
> +	int instance_size;
> +	const struct qmi_voice_call_information *call_information;
> +	const struct qmi_voice_remote_party_number *remote_party_number;
> +	const struct qmi_voice_remote_party_number_instance
> *remote_party_number_inst[16]; +
> +	static const uint8_t RESULT_CALL_STATUS_CALL_INFORMATION = 0x01;
> +	static const uint8_t RESULT_CALL_STATUS_REMOTE_NUMBER = 0x10;
> +	static const uint8_t RESULT_CALL_INFO_CALL_INFORMATION = 0x10;
> +	static const uint8_t RESULT_CALL_INFO_REMOTE_NUMBER = 0x11;
> +
> +	DBG("");
> +
> +	/* mandatory */
> +	call_information = qmi_result_get(
> +		result, RESULT_CALL_STATUS_CALL_INFORMATION, &len);
> +
> +	if (!call_information) {
> +		call_information = qmi_result_get(
> +			result, RESULT_CALL_INFO_CALL_INFORMATION,
> +			&len);
> +		status = false;
> +	}
> +
> +	if (!call_information || len < sizeof(call_information->size)) {
> +		DBG("Parsing of all call status indication failed");
> +		return;
> +	}
> +
> +	if (!call_information->size) {
> +		DBG("No call informations received!");
> +		return;
> +	}
> +
> +	if (len != call_information->size *
> +			sizeof(struct 
qmi_voice_call_information_instance) +
> +			sizeof(call_information->size)) {
> +		DBG("Call information size incorrect");
> +		return;
> +	}
> +
> +	/* mandatory */
> +	remote_party_number = qmi_result_get(
> +		result,
> +		status ? RESULT_CALL_STATUS_REMOTE_NUMBER :
> +			 RESULT_CALL_INFO_REMOTE_NUMBER,
> +		&len);
> +
> +	if (!remote_party_number) {
> +		DBG("Unable to retrieve remote numbers");
> +		return;
> +	}
> +
> +	/* verify the length */
> +	if (len < sizeof(remote_party_number->size)) {
> +		DBG("Parsing of remote numbers failed");
> +		return;
> +	}
> +
> +	/* expect we have valid fields for every call */
> +	if (call_information->size != remote_party_number->size) {
> +		DBG("Not all fields have the same size");
> +		return;
> +	}
> +
> +	/* pull the remote call info into a local array */
> +	instance_size = sizeof(struct 
qmi_voice_remote_party_number_instance);
> +
> +	for (i = 0, offset = sizeof(remote_party_number->size);
> +			offset < len && i < 16 && i < 
remote_party_number->size;
> +			i++) {
> +		const struct qmi_voice_remote_party_number_instance 
*instance;
> +
> +		if (offset + instance_size > len) {
> +			DBG("Error parsing remote numbers");
> +			return;
> +		}
> +
> +		instance = (void *)remote_party_number + offset;
> +		if (offset + instance_size + instance->number_size > len) 
{
> +			DBG("Error parsing remote numbers");
> +			return;
> +		}
> +
> +		remote_party_number_inst[i] = instance;
> +		offset +=
> +			sizeof(struct 
qmi_voice_remote_party_number_instance) +
> +			instance->number_size;
> +	}
> +
> +	struct l_queue *calls = l_queue_new();
> +
> +	for (i = 0; i < call_information->size && i < 16; i++) {
> +		struct ofono_call *call = l_new(struct ofono_call, 1);
> +		struct qmi_voice_call_information_instance call_info;
> +		const struct qmi_voice_remote_party_number_instance
> +			*remote_party = remote_party_number_inst[i];
> +		int number_size;
> +
> +		call_info = call_information->instance[i];
> +
> +		call->id = call_info.id;
> +		call->direction = 
qmi_to_ofono_direction(call_info.direction);
> +		call->type = 0; /* always voice */
> +
> +		number_size = MIN(remote_party->number_size,
> OFONO_MAX_PHONE_NUMBER_LENGTH); +		char *tmp =
> l_strndup(remote_party->number, number_size);
> +		l_strlcpy(call->phone_number.number, tmp,
> sizeof(call->phone_number.number)); +		l_free(tmp);
> +
> +		if (strlen(call->phone_number.number) > 0)
> +			call->clip_validity = 0;
> +		else
> +			call->clip_validity = 2;
> +
> +		if (qmi_to_ofono_status(call_info.state, &call->status)) 
{
> +			DBG("Ignore call id %d, because can not 
convert QMI state 0x%x to
> ofono.", +				call_info.id, call_info.state);
> +			l_free(call);
> +			continue;
> +		}
> +
> +		DBG("Call %d in state %s(%d)", call_info.id,
> +			qmi_voice_call_state_name(call_info.state),
> +			call_info.state);
> +
> +		l_queue_push_tail(calls, call);
> +	}
> +
> +	ofono_call_list_notify(vc, calls);
> +}
> +
> +static void dial_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct cb_data *cbd = user_data;
> +	struct ofono_voicecall *vc = cbd->user;
> +	ofono_voicecall_cb_t cb = cbd->cb;
> +	uint16_t error;
> +	uint8_t call_id;
> +
> +	static const uint8_t RESULT_CALL_ID = 0x10;
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, &error)) {
> +		DBG("QMI Error %d", error);
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;
> +	}
> +
> +	if (!qmi_result_get_uint8(result, RESULT_CALL_ID,
> +			&call_id)) {
> +		ofono_error("No call id in dial result");
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;
> +	}
> +
> +	DBG("New call QMI id %d", call_id);
> +	ofono_call_list_dial_callback(vc, call_id);
> +
> +	CALLBACK_WITH_SUCCESS(cb, cbd->data);
> +}
> +
> +static void dial(struct ofono_voicecall *vc,
> +			const struct ofono_phone_number *ph,
> +			enum ofono_clir_option clir, 
ofono_voicecall_cb_t cb,
> +			void *data)
> +{
> +	struct voicecall_data *vd = ofono_voicecall_get_data(vc);
> +	struct cb_data *cbd = cb_data_new(cb, data);
> +	struct qmi_param *param;
> +	const char *calling_number = phone_number_to_string(ph);
> +
> +	static const uint8_t PARAM_CALL_NUMBER = 0x01;
> +	static const uint8_t PARAM_CALL_TYPE = 0x10;
> +	static const uint8_t QMI_VOICE_CALL_TYPE_VOICE = 0x00;
> +
> +	DBG("");
> +
> +	cbd->user = vc;
> +	memcpy(&vd->dialed, ph, sizeof(*ph));
> +
> +	param = qmi_param_new();
> +
> +	if (!qmi_param_append(param, PARAM_CALL_NUMBER,
> +			strlen(calling_number), calling_number))
> +		goto error;
> +
> +	qmi_param_append_uint8(param, PARAM_CALL_TYPE,
> +				QMI_VOICE_CALL_TYPE_VOICE);
> +
> +	if (qmi_service_send(vd->voice, QMI_VOICE_DIAL_CALL, param, 
dial_cb,
> +				cbd, l_free) > 0)
> +		return;
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, data);
> +	l_free(cbd);
> +	l_free(param);
> +}
> +
>  static void create_voice_cb(struct qmi_service *service, void *user_data)
>  {
>  	struct ofono_voicecall *vc = user_data;
> @@ -58,6 +477,9 @@ static void create_voice_cb(struct qmi_service *service,
> void *user_data)
> 
>  	data->voice = qmi_service_ref(service);
> 
> +	qmi_service_register(data->voice, QMI_VOICE_ALL_CALL_STATUS_IND,
> +				all_call_status_ind, vc, NULL);
> +
>  	ofono_voicecall_register(vc);
>  }
> 
> @@ -70,6 +492,7 @@ static int qmi_voicecall_probe(struct ofono_voicecall
> *vc, DBG("");
> 
>  	data = l_new(struct voicecall_data, 1);
> +	data->call_list = l_queue_new();
> 
>  	ofono_voicecall_set_data(vc, data);
> 
> @@ -77,7 +500,6 @@ static int qmi_voicecall_probe(struct ofono_voicecall
> *vc, create_voice_cb, vc, NULL);
> 
>  	return 0;
> -
>  }
> 
>  static void qmi_voicecall_remove(struct ofono_voicecall *vc)
> @@ -92,12 +514,14 @@ static void qmi_voicecall_remove(struct ofono_voicecall
> *vc)
> 
>  	qmi_service_unref(data->voice);
> 
> +	l_queue_destroy(data->call_list, l_free);
>  	l_free(data);
>  }
> 
>  static const struct ofono_voicecall_driver driver = {
>  	.probe		= qmi_voicecall_probe,
>  	.remove		= qmi_voicecall_remove,
> +	.dial		= dial,
>  };
> 
>  OFONO_ATOM_DRIVER_BUILTIN(voicecall, qmimodem, &driver)




