using Toybox.Time;
using Toybox.Time.Gregorian;
import Toybox.System;

module Quotes {
  
  function getQuote() {
    var quotes = [
        "The best revenge is not to be like your enemy.",
        "Control your mind or it will control you.",
        "We suffer more in imagination than in reality.",
        "Waste no more time arguing what a good man is.",
        "To be calm is the highest achievement of self.",
        "Happiness depends on the quality of your thoughts.",
        "The obstacle is the way.",
        "Silence is a source of great strength.",
        "Fate leads the willing, drags the unwilling.",
        "It is not events, but our thoughts about them.",
        "You have power over your mind, not outside events.",
        "What we do now echoes in eternity.",
        "Be tolerant with others and strict with yourself.",
        "First say to yourself what you would be.",
        "No man is free who is not master of himself.",
        "We control how we respond, not what happens.",
        "Better to trip with the feet than with the tongue.",
        "Wealth consists not in having great possessions.",
        "Man conquers the world by conquering himself.",
        "Self-control is strength. Calmness is mastery.",
        "Begin each day with gratitude and focus.",
        "A gem cannot be polished without friction.",
        "Freedom is the only worthy goal in life.",
        "We cannot choose our external circumstances.",
        "Fear is a choice. Danger is real.",
        "Turn obstacles into opportunities.",
        "He suffers more who fears suffering.",
        "Be present. The past and future don’t exist now.",
        "Act with purpose, not for applause.",
        "Adversity reveals one’s true character.",
        "The wise learn from everyone.",
        "Live simply, so others may simply live.",
        "Dwell on the beauty of life.",
        "Be kind, for everyone is fighting a hard battle.",
        "Self-reverence, self-knowledge, self-control.",
        "Success is internal, not external.",
        "Do not explain your philosophy. Embody it.",
        "Make peace with imperfection.",
        "Courage is resistance to fear, mastery of fear.",
        "Wisdom begins in wonder.",
        "Master yourself and you master the world.",
        "Don’t explain your behavior, just correct it.",
        "Character is fate.",
        "Be as you wish to seem.",
        "Effort never betrays.",
        "Nothing endures but change.",
        "Time is a created thing; say 'I have time.'",
        "Perfection is not attainable, but we chase it.",
        "Difficulties strengthen the mind.",
        "Practice makes progress, not perfection.",
        "Good character is the best tombstone.",
        "Progress, not perfection.",
        "Do what is right, not what is easy.",
        "Calm mind brings inner strength.",
        "Do less, but better.",
        "Focus on what you can control.",
        "Your life is as good as your mindset.",
        "Resilience is key.",
        "Be steady and well-ordered in your life.",
        "Be loyal to your principles.",
        "Let your actions define you.",
        "Live wisely and die well.",
        "Keep learning. Never stop improving.",
        "Knowledge speaks, but wisdom listens.",
        "Be patient. Great things take time.",
        "Action cures fear.",
        "Courage starts with showing up.",
        "Life is short. Focus on what matters.",
        "Let your life be your argument.",
        "Strength comes from overcoming challenges.",
        "Do what is meaningful, not what is expedient.",
        "Stay focused on your goals, not your fears.",
        "Growth begins at the end of your comfort zone.",
        "Success is a journey, not a destination.",
        "Your potential is endless. Keep striving.",
        "Be the change you wish to see in the world.",
        "Never give up. Great things take time.",
        "Discipline equals freedom.",
        "You become what you repeatedly do.",
        "Every day is a fresh start. Embrace it.",
        "Success is no accident; it’s hard work.",
        "Choose to be optimistic, it feels better.",
        "Patience and perseverance conquer all things.",
        "Your attitude determines your direction.",
        "The secret of change is to focus on progress.",
        "Great things never came from comfort zones.",
        "The only limit to our achievements is doubt.",
        "Life isn’t about waiting for the storm to pass.",
        "The best revenge is not to be like your enemy.",
        "Control your mind or it will control you.",
        "We suffer more in imagination than in reality.",
        "Waste no more time arguing what a good man is.",
        "To be calm is the highest achievement of self.",
        "Happiness depends on the quality of your thoughts.",
        "The obstacle is the way.",
        "Silence is a source of great strength.",
        "Fate leads the willing, drags the unwilling.",
        "It is not events, but our thoughts about them.",
        "You have power over your mind, not outside events.",
        "What we do now echoes in eternity.",
        "Be tolerant with others and strict with yourself.",
        "First say to yourself what you would be.",
        "No man is free who is not master of himself.",
        "We control how we respond, not what happens.",
        "Better to trip with the feet than with the tongue.",
        "Wealth consists not in having great possessions.",
        "Man conquers the world by conquering himself.",
        "Self-control is strength. Calmness is mastery.",
        "Begin each day with gratitude and focus.",
        "A gem cannot be polished without friction.",
        "Freedom is the only worthy goal in life.",
        "We cannot choose our external circumstances.",
        "Fear is a choice. Danger is real.",
        "Turn obstacles into opportunities.",
        "He suffers more who fears suffering.",
        "Be present. The past and future don’t exist now.",
        "Act with purpose, not for applause.",
        "Adversity reveals one’s true character.",
        "The wise learn from everyone.",
        "Live simply, so others may simply live.",
        "Dwell on the beauty of life.",
        "Be kind, for everyone is fighting a hard battle.",
        "Self-reverence, self-knowledge, self-control.",
        "Success is internal, not external.",
        "Do not explain your philosophy. Embody it.",
        "Make peace with imperfection.",
        "Courage is resistance to fear, mastery of fear.",
        "Wisdom begins in wonder.",
        "Master yourself and you master the world.",
        "Don’t explain your behavior, just correct it.",
        "Character is fate.",
        "Be as you wish to seem.",
        "Effort never betrays.",
        "Nothing endures but change.",
        "Time is a created thing; say 'I have time.'",
        "Perfection is not attainable, but we chase it.",
        "Difficulties strengthen the mind.",
        "Practice makes progress, not perfection.",
        "Good character is the best tombstone.",
        "Progress, not perfection.",
        "Do what is right, not what is easy.",
        "Calm mind brings inner strength.",
        "Do less, but better.",
        "Focus on what you can control.",
        "Your life is as good as your mindset.",
        "Resilience is key.",
        "Be steady and well-ordered in your life.",
        "Be loyal to your principles.",
        "Let your actions define you.",
        "Live wisely and die well.",
        "Keep learning. Never stop improving.",
        "Knowledge speaks, but wisdom listens.",
        "Be patient. Great things take time.",
        "Action cures fear.",
        "Courage starts with showing up.",
        "Life is short. Focus on what matters.",
        "Let your life be your argument.",
        "Strength comes from overcoming challenges.",
        "Do what is meaningful, not what is expedient.",
        "Stay focused on your goals, not your fears.",
        "Growth begins at the end of your comfort zone.",
        "Success is a journey, not a destination.",
        "Your potential is endless. Keep striving.",
        "Be the change you wish to see in the world.",
        "Never give up. Great things take time.",
        "Discipline equals freedom.",
        "You become what you repeatedly do.",
        "Every day is a fresh start. Embrace it.",
        "Success is no accident; it’s hard work.",
        "Choose to be optimistic, it feels better.",
        "Patience and perseverance conquer all things.",
        "Your attitude determines your direction.",
        "The secret of change is to focus on progress.",
        "Great things never came from comfort zones.",
        "The only limit to our achievements is doubt.",
        "Life isn’t about waiting for the storm to pass.",
        "Success is built on daily habits, not luck.",
        "What you think, you become.",
        "Action is the foundational key to success.",
        "The best revenge is not to be like your enemy.",
        "Control your mind or it will control you.",
        "We suffer more in imagination than in reality.",
        "Waste no more time arguing what a good man is.",
        "To be calm is the highest achievement of self.",
        "Happiness depends on the quality of your thoughts.",
        "The obstacle is the way.",
        "Silence is a source of great strength.",
        "Fate leads the willing, drags the unwilling.",
        "It is not events, but our thoughts about them.",
        "You have power over your mind, not outside events.",
        "What we do now echoes in eternity.",
        "Be tolerant with others and strict with yourself.",
        "First say to yourself what you would be.",
        "No man is free who is not master of himself.",
        "We control how we respond, not what happens.",
        "Better to trip with the feet than with the tongue.",
        "Wealth consists not in having great possessions.",
        "Man conquers the world by conquering himself.",
        "Self-control is strength. Calmness is mastery.",
        "Begin each day with gratitude and focus.",
        "A gem cannot be polished without friction.",
        "Freedom is the only worthy goal in life.",
        "We cannot choose our external circumstances.",
        "Fear is a choice. Danger is real.",
        "Turn obstacles into opportunities.",
        "He suffers more who fears suffering.",
        "Be present. The past and future don’t exist now.",
        "Act with purpose, not for applause.",
        "Adversity reveals one’s true character.",
        "The wise learn from everyone.",
        "Live simply, so others may simply live.",
        "Dwell on the beauty of life.",
        "Be kind, for everyone is fighting a hard battle.",
        "Self-reverence, self-knowledge, self-control.",
        "Success is internal, not external.",
        "Do not explain your philosophy. Embody it.",
        "Make peace with imperfection.",
        "Courage is resistance to fear, mastery of fear.",
        "Wisdom begins in wonder.",
        "Master yourself and you master the world.",
        "Don’t explain your behavior, just correct it.",
        "Character is fate.",
        "Be as you wish to seem.",
        "Effort never betrays.",
        "Nothing endures but change.",
        "Time is a created thing; say 'I have time.'",
        "Perfection is not attainable, but we chase it.",
        "Difficulties strengthen the mind.",
        "Practice makes progress, not perfection.",
        "Good character is the best tombstone.",
        "Progress, not perfection.",
        "Do what is right, not what is easy.",
        "Calm mind brings inner strength.",
        "Do less, but better.",
        "Focus on what you can control.",
        "Your life is as good as your mindset.",
        "Resilience is key.",
        "Be steady and well-ordered in your life.",
        "Be loyal to your principles.",
        "Let your actions define you.",
        "Live wisely and die well.",
        "Keep learning. Never stop improving.",
        "Knowledge speaks, but wisdom listens.",
        "Be patient. Great things take time.",
        "Action cures fear.",
        "Courage starts with showing up.",
        "Life is short. Focus on what matters.",
        "Let your life be your argument.",
        "Strength comes from overcoming challenges.",
        "Do what is meaningful, not what is expedient.",
        "Stay focused on your goals, not your fears.",
        "Growth begins at the end of your comfort zone.",
        "Success is a journey, not a destination.",
        "Your potential is endless. Keep striving.",
        "Be the change you wish to see in the world.",
        "Never give up. Great things take time.",
        "Discipline equals freedom.",
        "You become what you repeatedly do.",
        "Every day is a fresh start. Embrace it.",
        "Success is no accident; it’s hard work.",
        "Choose to be optimistic, it feels better.",
        "Patience and perseverance conquer all things.",
        "Your attitude determines your direction.",
        "The secret of change is to focus on progress.",
        "Great things never came from comfort zones.",
        "The only limit to our achievements is doubt.",
        "Life isn’t about waiting for the storm to pass.",
        "The best revenge is not to be like your enemy.",
        "Control your mind or it will control you.",
        "We suffer more in imagination than in reality.",
        "Waste no more time arguing what a good man is.",
        "To be calm is the highest achievement of self.",
        "Happiness depends on the quality of your thoughts.",
        "The obstacle is the way.",
        "Silence is a source of great strength.",
        "Fate leads the willing, drags the unwilling.",
        "It is not events, but our thoughts about them.",
        "You have power over your mind, not outside events.",
        "What we do now echoes in eternity.",
        "Be tolerant with others and strict with yourself.",
        "First say to yourself what you would be.",
        "No man is free who is not master of himself.",
        "We control how we respond, not what happens.",
        "Better to trip with the feet than with the tongue.",
        "Wealth consists not in having great possessions.",
        "Man conquers the world by conquering himself.",
        "Self-control is strength. Calmness is mastery.",
        "Begin each day with gratitude and focus.",
        "A gem cannot be polished without friction.",
        "Freedom is the only worthy goal in life.",
        "We cannot choose our external circumstances.",
        "Fear is a choice. Danger is real.",
        "Turn obstacles into opportunities.",
        "He suffers more who fears suffering.",
        "Be present. The past and future don’t exist now.",
        "Act with purpose, not for applause.",
        "Adversity reveals one’s true character.",
        "The wise learn from everyone.",
        "Live simply, so others may simply live.",
        "Dwell on the beauty of life.",
        "Be kind, for everyone is fighting a hard battle.",
        "Self-reverence, self-knowledge, self-control.",
        "Success is internal, not external.",
        "Do not explain your philosophy. Embody it.",
        "Make peace with imperfection.",
        "Courage is resistance to fear, mastery of fear.",
        "Wisdom begins in wonder.",
        "Master yourself and you master the world.",
        "Don’t explain your behavior, just correct it.",
        "Character is fate.",
        "Be as you wish to seem.",
        "Effort never betrays.",
        "Nothing endures but change.",
        "Time is a created thing; say 'I have time.'",
        "Perfection is not attainable, but we chase it.",
        "Difficulties strengthen the mind.",
        "Practice makes progress, not perfection.",
        "Good character is the best tombstone.",
        "Progress, not perfection.",
        "Do what is right, not what is easy.",
        "The best revenge is not to be like your enemy.",
        "Control your mind or it will control you.",
        "We suffer more in imagination than in reality.",
        "Waste no more time arguing what a good man is.",
        "To be calm is the highest achievement of self.",
        "Happiness depends on the quality of your thoughts.",
        "The obstacle is the way.",
        "Silence is a source of great strength.",
        "Fate leads the willing, drags the unwilling.",
        "It is not events, but our thoughts about them.",
        "You have power over your mind, not outside events.",
        "What we do now echoes in eternity.",
        "Be tolerant with others and strict with yourself.",
        "First say to yourself what you would be.",
        "No man is free who is not master of himself.",
        "We control how we respond, not what happens.",
        "Better to trip with the feet than with the tongue.",
        "Wealth consists not in having great possessions.",
        "Man conquers the world by conquering himself.",
        "Self-control is strength. Calmness is mastery.",
        "Begin each day with gratitude and focus.",
        "A gem cannot be polished without friction.",
        "Freedom is the only worthy goal in life.",
        "We cannot choose our external circumstances.",
        "Fear is a choice. Danger is real.",
        "Turn obstacles into opportunities.",
        "He suffers more who fears suffering.",
        "Be present. The past and future don’t exist now.",
        "Act with purpose, not for applause.",
        "Adversity reveals one’s true character.",
        "The wise learn from everyone.",
        "Live simply, so others may simply live.",
        "Dwell on the beauty of life.",
        "Be kind, for everyone is fighting a hard battle.",
        "Self-reverence, self-knowledge, self-control.",
        "Success is internal, not external.",
        "Do not explain your philosophy. Embody it.",
        "Make peace with imperfection.",
        "Courage is resistance to fear, mastery of fear.",
        "Wisdom begins in wonder.",
        "Master yourself and you master the world.",
        "Don’t explain your behavior, just correct it.",
        "Character is fate.",
        "Be as you wish to seem.",
        "Effort never betrays."
    ];
    var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
    var startOfYear = Gregorian.moment({
      :year => today.year,
      :month => 1,
      :day =>  1,
      :hour => 0,
      :min => 0,
      :sec => 0
    });
    var currentDate = Gregorian.moment({
      :year => today.year,
      :month => today.month,
      :day =>  today.day,
      :hour => today.hour,
      :min => today.min,
      :sec => today.sec
    });
    var diff = currentDate.subtract(startOfYear);
    var diffInSeconds = diff.value();
    var index = (diffInSeconds / 60 / 60 / 24) - 1;
    if (index >= 0 && index < quotes.size()) {
      return quotes[index];
    } else {
      return quotes[0];
    }
  }
}